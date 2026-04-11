# Chapter 3 Source Ledger

This file tracks substantive sources used in the empirical and theory-to-code workflow for Chapter 3.

## Dissertation Sources

- Atkinson (1970): social-welfare approach to inequality measures.
- Gilboa and Schmeidler (1989): maxmin expected utility.
- Gilboa (2009), _Theory of Decision under Uncertainty_.
- Federal Reserve Board, Survey of Consumer Finances (SCF) public data pages and CSV extracts.
- Federal Reserve Board notes on racial disparities in wealth from the SCF.

## Implementation References

- Local repo: `/Volumes/SSD PRO/Github-forks/scf-tools`
  - `src/fedsurvey/scf/download.py`
  - `src/fedsurvey/scf/process.py`
  - `src/fedsurvey/scf/merge.py`

## Notes

- The downloader in this repo follows the direct SCF zip pattern already used in `scf-tools`: `scfp{year}excel.zip`.
- The current parser expects SCF columns for race, weight, net worth, and gross assets consistent with the summary extract files.
- Before the chapter text is finalized, substantive sources from this ledger should be added to both Chapter 3's bibliography and the main dissertation bibliography.
