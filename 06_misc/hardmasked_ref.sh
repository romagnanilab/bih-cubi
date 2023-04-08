# Creating a mitochondrial-read-hardmasked reference```
```
mamba create -y -n sctools bedtools
mamba activate sctools

export PATH=/u/usr/bin/cellranger-atac-2.1.0:$PATH

genome="" # enter end folder name here
version="A" 
build="${genome}-${version}-build"
mkdir -p "$build"

source="${genome}-${version}-reference-sources"
mkdir -p "$source"
fasta_url="http://ftp.ensembl.org/pub/release-98/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"
fasta_in="${source}/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
gtf_url="https://storage.googleapis.com/generecovery/human_GRCh38_optimized_annotation_v2.gtf.gz"
gunzip human_GRCh38_optimized_annotation_v2.gtf.gz
gtf_in="${source}/human_GRCh38_optimized_annotation_v2.gtf"
motifs_url="https://jaspar.genereg.net/download/data/2022/CORE/JASPAR2022_CORE_non-redundant_pfms_jaspar.txt"
motifs_in="${source}/JASPAR2018_CORE_non-redundant_pfms_jaspar.txt"

if [ ! -f "$fasta_in" ]; then
    curl -sS "$fasta_url" | zcat > "$fasta_in"
fi
if [ ! -f "$gtf_in" ]; then
    curl -sS "$gtf_url" | zcat > "$gtf_in"
fi
if [ ! -f "$motifs_in" ]; then
    curl -sS "$motifs_url" > "$motifs_in"
fi

fasta_modified="$build/$(basename "$fasta_in").modified"
cat "$fasta_in" \
    | sed -E 's/^>(\S+).*/>\1 \1/' \
    | sed -E 's/^>([0-9]+|[XY]) />chr\1 /' \
    | sed -E 's/^>MT />chrM /' \
    > "$fasta_modified"

motifs_modified="$build/$(basename "$motifs_in").modified"
awk '{
    if ( substr($1, 1, 1) == ">" ) {
        print ">" $2 "_" substr($1,2)
    } else {
        print
    }
}' "$motifs_in" > "$motifs_modified"

wget https://raw.githubusercontent.com/caleblareau/mitoblacklist/master/combinedBlacklist/hg38.full.blacklist.bed
cd GRCh38-2020-A-build
mv Homo_sapiens.GRCh38.dna.primary_assembly.fa.modified old_Homo_sapiens.GRCh38.dna.primary_assembly.fa.modified
bedtools maskfasta -fi old_Homo_sapiens.GRCh38.dna.primary_assembly.fa.modified -bed ../hg38.full.blacklist.bed  -fo hardmasked_genome.fa
cd ..

config_in="${build}/GRCh38_mask.config"
echo """{
    organism: \"Homo_sapiens\"
    genome: [\""$genome"\"]
    input_fasta: [\""$build/hardmasked_genome.fa"\"]
    input_gtf: [\""$gtf_in"\"]
    input_motifs: \""$motifs_modified"\"
    non_nuclear_contigs: [\"chrM\"]
}""" > "$config_in"

cellranger-arc mkref --ref-version="$version" --config="$config_in"
```
