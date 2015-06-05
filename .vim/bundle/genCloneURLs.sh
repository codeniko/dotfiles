#!/bin/bash

outfile="cloneBundles.sh"

if [ -f "${outfile}" ]; then
	/bin/rm -f "${outfile}"
fi

/usr/bin/touch "${outfile}"
/bin/chmod u+x "${outfile}"

for filename in *; do
	/bin/echo "${filename}" | grep -q -E -e '.sh$'
	if [ $? -gt 0 ]; then
		repo=`grep -e 'url = ' "${filename}/.git/config" | /usr/bin/cut -d ' ' -f 3` 
		/bin/echo "git clone \"${repo}\"" >> "${outfile}"
	fi
done

exit 0
