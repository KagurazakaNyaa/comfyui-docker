#!/bin/bash

set -Eeuo pipefail

api_args=(--fail --silent --show-error --location --retry 3 --retry-delay 2)
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    api_args+=(--header "Authorization: Bearer ${GITHUB_TOKEN}")
fi

response_file=$(mktemp)
trap 'rm -f "$response_file"' EXIT

if ! curl "${api_args[@]}" \
    "https://api.github.com/repos/Comfy-Org/ComfyUI/releases/latest" \
    >"$response_file"; then
    echo "Failed to query the latest ComfyUI release" >&2
    exit 1
fi

onlineversion=$(python3 - "$response_file" <<'PY'
import json
import re
import sys

with open(sys.argv[1], encoding="utf-8") as response:
    payload = json.load(response)
tag = payload.get("tag_name")
if not isinstance(tag, str) or not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
    raise SystemExit("GitHub latest release did not contain a valid release tag")
print(tag)
PY
)
repoversion=$(<VERSION)

echo "repoversion:$repoversion onlineversion:$onlineversion"

if [[ "$repoversion" == "$onlineversion" ]]; then
    exit 0
fi

printf '%s\n' "$onlineversion" > VERSION
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add VERSION
git commit -m "Auto update to version $onlineversion"
git tag "$onlineversion"
git push
git push origin "$onlineversion"
