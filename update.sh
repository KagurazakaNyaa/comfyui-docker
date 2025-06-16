#!/bin/bash

onlineversion=$(curl --silent -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/repos/comfyanonymous/ComfyUI/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
repoversion=$(cat VERSION)

echo "repoversion:$repoversion onlineversion:$onlineversion"
echo "$onlineversion" >VERSION

if [[ "$repoversion" == "$onlineversion" ]]; then
    exit
fi
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add VERSION
git commit -m "Auto update to version $onlineversion"
git tag -f "$onlineversion"
git push
git push origin --tags -f
