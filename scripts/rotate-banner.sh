#!/usr/bin/env bash
# Rota el banner del README entre los GIFs de assets/banner-*.gif (uno por día).
set -euo pipefail
cd "$(dirname "$0")/.."

files=(assets/banner-*.gif)
day=$((10#$(date -u +%j)))
pick="${files[$((day % ${#files[@]}))]}"

python3 - "$pick" <<'PY'
import re, sys
pick = sys.argv[1]
text = open("README.md", encoding="utf8").read()
new = f'<!--BANNER-START--><img src="{pick}" width="720" alt="banner" /><!--BANNER-END-->'
out = re.sub(r"<!--BANNER-START-->.*?<!--BANNER-END-->", new, text, flags=re.S)
open("README.md", "w", encoding="utf8").write(out)
PY
echo "banner: $pick"
