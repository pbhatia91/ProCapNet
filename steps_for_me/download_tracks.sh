#!/bin/bash

# Create a directory to hold your tracks
mkdir -p procapnet_tracks
cd procapnet_tracks

# Base URL for ENCODE downloads
BASE_URL="https://www.encodeproject.org/files"

# Array of cell lines and their corresponding file IDs (Observed +, Observed -, Predicted +, Predicted -)
# IDs extracted from Supplementary Table 5
declare -A tracks=(
    ["K562"]="ENCFF798GNW ENCFF662SHP ENCFF810TSX ENCFF977ZRF"
    ["A673"]="ENCFF484JMU ENCFF248NRG ENCFF245QOS ENCFF568EMG"
    ["Caco-2"]="ENCFF290ILU ENCFF674WYH ENCFF781NNR ENCFF512NRZ"
    ["Calu3"]="ENCFF726ZFO ENCFF694ACJ ENCFF297DYW ENCFF726MZN"
    ["HUVEC"]="ENCFF515GWR ENCFF932EJP ENCFF522DPN ENCFF130FIR"
    ["MCF10A"]="ENCFF460DXE ENCFF466PYB ENCFF413SKO ENCFF751HYG"
)

# Loop through and download
for cell in "${!tracks[@]}"; do
    mkdir -p "$cell"
    
    # Read the file IDs for the current cell line
    read -r obs_pos obs_neg pred_pos pred_neg <<< "${tracks[$cell]}"
    
    echo "Downloading tracks for $cell..."
    
    # Download Observed (Measured) Tracks
    wget -q --show-progress "${BASE_URL}/${obs_pos}/@@download/${obs_pos}.bigWig" -O "${cell}/${cell}_observed_pos.bigWig"
    wget -q --show-progress "${BASE_URL}/${obs_neg}/@@download/${obs_neg}.bigWig" -O "${cell}/${cell}_observed_neg.bigWig"
    
    # Download Predicted Tracks
    wget -q --show-progress "${BASE_URL}/${pred_pos}/@@download/${pred_pos}.bigWig" -O "${cell}/${cell}_predicted_pos.bigWig"
    wget -q --show-progress "${BASE_URL}/${pred_neg}/@@download/${pred_neg}.bigWig" -O "${cell}/${cell}_predicted_neg.bigWig"
    
done

echo "All downloads complete!"
