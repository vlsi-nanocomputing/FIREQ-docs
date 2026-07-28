from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parents[1]

project = "FIREQ"
author = "QNANO - Politecnico di Torino"
copyright = "2026, QNANO - Politecnico di Torino"

release_file = ROOT / "fireq-release.yaml"
if release_file.exists():
    with release_file.open("r", encoding="utf-8") as f:
        release_data = yaml.safe_load(f)
    release = str(release_data.get("fireq_release", "dev"))
else:
    release = "dev"

extensions = [
    "myst_parser",
    "sphinx.ext.githubpages",
    "sphinx_copybutton",
]

html_theme = "pydata_sphinx_theme"

html_theme_options = {
    "github_url": "https://github.com/vlsi-nanocomputing/FIREQ-docs",
    "navbar_align": "left",
}

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "dollarmath",
]
