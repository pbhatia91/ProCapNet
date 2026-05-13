# Running ProCapNet on BlueBEAR

## Result verification with YC-YR split tracks

I initially tried to download the tracks for predictions of PRO-cap data but it seems that the uploads for that have been removed. So I have to re-generate the predictions using the uploaded model weights.

### Step 1: Download genome

```
./src/0_download_files/0.0_download_genome.sh
```

### Step 2: Add observed signal tracks to the processed data directory

```
# Create the directory the scripts expect
mkdir -p data/procap/processed/K562
cd data/procap/processed/K562

# Download Observed Signal (+) and rename
curl -f -L "https://www.encodeproject.org/files/ENCFF798GNW/@@download/ENCFF798GNW.bigWig" -o 5prime.pos.bigWig

# Download Observed Signal (-) and rename
curl -f -L "https://www.encodeproject.org/files/ENCFF662SHP/@@download/ENCFF662SHP.bigWig" -o 5prime.neg.bigWig

# Download the selected regions (peaks) and rename
curl -f -L "https://www.encodeproject.org/files/ENCFF271LOH/@@download/ENCFF271LOH.bed.gz" -o peaks.bed.gz

cd ../../../..
```

### Step 3: Download models

```
mkdir -p models/procap/K562/strand_merged_umap
cd models/procap/K562/strand_merged_umap

curl -f -L \
  "https://www.encodeproject.org/files/ENCFF976FHE/@@download/ENCFF976FHE.tar.gz" \
  -o models.tar.gz
```




