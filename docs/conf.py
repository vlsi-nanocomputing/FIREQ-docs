import sys
from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parents[1]
    

project = "FIREQ"
author = "QNANO - Politecnico di Torino"
copyright = "2026, QNANO - Politecnico di Torino"



server_src = ROOT / "docs" / "repos" / "FIREQ-Server"
if server_src.exists():
    sys.path.insert(0, str(server_src))

client_src = ROOT / "docs" / "repos" / "FIREQ-Client"
if client_src.exists():
    sys.path.insert(0, str(client_src))

    
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
    'sphinx.ext.intersphinx',
    'sphinx.ext.mathjax',
    "sphinx.ext.autodoc",
    "sphinx.ext.autosummary",
    "sphinx.ext.napoleon",
    "sphinx.ext.viewcode",
    "sphinx.ext.extlinks",
    "sphinx_design",
]



# Autodoc & Autosummary Configurations
autodoc_member_order = "bysource"
autodoc_default_options = {
    "members": True,
    "show-inheritance": True,
}
autosummary_generate = True

# Hardware Mocking for CI/CD builds
autodoc_mock_imports = [
    "pynq",
    "msgpack",
    "tqdm",
    "anytree",
    "pandas",
    "prompt_toolkit",
    "xrfclk",
    "matplotlib",
    "xrfdc",
    "cffi",
    "psutil",
    "networkx",
    "numpy",
]

templates_path = ["_templates"]
html_static_path = ["_static"]

html_css_files = [
    "fireq.css",
]

html_logo = "_static/fireq-logo.svg"
html_favicon = "_static/favicon.ico"

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

exclude_patterns = [
    "_build",
    "Thumbs.db",
    ".DS_Store",

    # Legacy generated import directory.
    "imported/**",

    # Generated repository staging area.
    # README files outside component docs trees are available for include
    # directives but should not be treated as standalone Sphinx pages.
    "repos/*/README.md",
    "repos/*/readme.md",
    "repos/*/README.rst",
    "repos/*/readme.rst",
    "repos/*/**/README.md",
    "repos/*/**/readme.md",
    "repos/*/**/README.rst",
    "repos/*/**/readme.rst",
]