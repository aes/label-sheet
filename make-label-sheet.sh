#!/bin/bash

if [ -r ~/.config/label-sheet/config ]; then
  source ~/.config/label-sheet/config
elif [ -r "label-sheet.config" ]; then
  source "label-sheet.config"
fi

if [ -r ~/.config/label-sheet/template.ps ]; then
  template=~/.config/label-sheet/template.ps
elif [ -r template.ps ]; then
  template=template.ps
fi

END=$(grep 'codePair$' template-small.ps);
END="${END##*(}"
END="10#${END%%)*}"
template="$(cat "$template")"

template="${template/URL_BASE/$url_base}"
template="${template/VCARD/$vcard}"
template="${template/LINE1/$line1}"
template="${template/LINE2/$line2}"

for ((i=0; i <= END; i++)); do
  a=$((RANDOM % 256))
  b=$((RANDOM % 4096))
  c=$((RANDOM % 4096))
  x="$(printf "%02x%03x%03x" $a $b $c )"
  j="$(printf "%08d" $i)"
  template="${template/($j)/($x)}"
done

name=$(date +%s.%N.ps)

printf "%s" "$template" > "$name"
