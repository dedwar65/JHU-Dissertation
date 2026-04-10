# Dissertation Source

This repository is the master Johns Hopkins dissertation project for Decory
Edwards. The JHU template remains the formatting base, but the sample content
has been replaced with imported dissertation chapters and a shared
bibliography.

`00-main.tex` is the only root file you need on Overleaf.

## Structure

- `00-main.tex`: master dissertation file
- `metadata.tex`: title-page, author, date, and committee metadata
- `02-abstract.tex`: dissertation-wide abstract
- `04-acknowledgement.tex`: acknowledgments page
- `06-chapter-1.tex`: wrapper for Chapter 1 body files
- `07-chapter-2.tex`: wrapper for Chapter 2 body files
- `08-chapter-3.tex`: wrapper for Chapter 3 body files
- `11-appendix-A.tex`: supplementary appendix for Chapter 2
- `12-appendix-B.tex`: supplementary appendix for Chapter 3
- `chapters/chapter1`: imported compile assets for Chapter 1
- `chapters/chapter2`: imported compile assets for Chapter 2
- `chapters/chapter3`: imported compile assets for Chapter 3
- `thesis.bib`: merged and deduplicated bibliography used by the dissertation
- `scripts/import_chapters.sh`: refreshes imported chapter assets from the
  local source repositories

## Chapter Import Workflow

The dissertation repo is intentionally self-contained for GitHub and Overleaf.
That means Overleaf never reaches into the original chapter repositories
directly.

When the chapter source repos change locally, run:

```bash
./scripts/import_chapters.sh
```

Set source paths when running the import script:

```bash
CHAPTER1_SRC="/path/to/ch1" CHAPTER2_SRC="/path/to/ch2" CHAPTER3_SRC="/path/to/ch3" ./scripts/import_chapters.sh
```

The script copies only compile-relevant source material into `chapters/` and
rebuilds `thesis.bib`.

## Overleaf Workflow

1. Push this repository to GitHub.
2. Link or import the repo into Overleaf.
3. Set `00-main.tex` as the root file if Overleaf does not pick it up
   automatically.
4. Compile the dissertation from the master project, not from an individual
   chapter file.

## Notes

- The current dissertation abstract and title are working versions assembled
  from the existing chapter material and should be revised once all chapters
  are finalized.
- If local bibliography compilation fails because of a `biber` version
  mismatch, make sure the TeX distribution copy of `biber` comes before the
  Homebrew copy on your `PATH`. On this Mac, `/Library/TeX/texbin/biber`
  matches the installed LaTeX packages.
- Optional template pages such as the dedication and epigraph are currently not
  included in the build, but the files can be restored later if needed.
- The repository structure is designed so that GitHub and Overleaf always have
  every file required to compile the dissertation.
