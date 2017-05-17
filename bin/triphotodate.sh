declare -i nbPhotos=0

for fichier in *
do
	if [ ! -f $fichier ]; then continue; fi
	MimeType=$(file --mime-type $fichier)
	if [[ ${MimeType:(-10)} != "image/jpeg" ]]; then continue; fi

	datePhoto=$(exiv2 -g Exif.Photo.DateTimeOriginal $fichier | sed -r 's/^ *//;s/ {1,}/ /g'| cut -d " " -f 4 | sed 's/:/-/g')
	anneePhoto=$(exiv2 -g Exif.Photo.DateTimeOriginal $fichier | sed -r 's/^ *//;s/ {1,}/ /g'| cut -d " " -f 4| cut -d ":" -f 1)
	if [ ! -z $datePhoto ]; then
		if [ ! -d "$anneePhoto" ]; then
			mkdir "$anneePhoto"
			echo "Creation de l'annee : $anneePhoto"
		fi
		if [ ! -d "$anneePhoto/$datePhoto" ]; then
			mkdir "$anneePhoto/$datePhoto"
		fi
		echo "mv $fichier vers $anneePhoto/$datePhoto"
		mv "$fichier" "$anneePhoto/$datePhoto/"
	fi
done

