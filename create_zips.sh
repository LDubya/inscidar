# zip all files for bulk download
cd assets/csv

# ------------------------------------------------------------ #

# zip all files
zip -r ./zips/all/a11y-evaluations.zip . -i "*.csv"

# ------------------------------------------------------------ #

# zip files by date
for folder in *; do
    if [ "$folder" != "zips" ]; then
        zip -r ./zips/by_date/${folder}.zip "$folder"
    fi
done

# ------------------------------------------------------------ #

# zip files by file name
files=$(find . -type f -name "*.csv" | sed 's|.*/||; s|\.csv$||' | sort | uniq)

# first copy over files with new name
for folder in *; do
    if [ "$folder" != "zips" ]; then
        echo folder $folder
        for file_path in $folder/*; do
            file_name=$(echo "$file_path" | sed 's|.*/||; s|\.csv$||')
            file_name_new="${folder}_${file_name}.csv"
            mkdir -p "./zips/by_name/${file_name}"
            cp "$file_path" ./zips/by_name/${file_name}/${file_name_new}
        done
    fi
done

# zip new folders
for folder in ./zips/by_name/*; do
    if [ -d "$folder" ]; then
    zip -r -j ${folder}.zip "$folder"
    rm -r $folder
    fi
done

# ------------------------------------------------------------ #