# Inequality Measure Computation Notes

This note documents exactly how the computational pipeline maps the chapter equations into code.

## Scope

For each SCF year `t`, wealth measure `m in {net_wealth, gross_assets}`, and treatment `tau`, we compute:
- objective welfare index: `I^O_{t,m,tau}`
- ambiguity welfare index: `I^A_{t,m,tau}`

States are:
- `S = {white, black}`

Ambiguity set is:
- `C = Delta(S)`

So the ambiguity aggregator is maxmin across race-state expected utilities.

## Data Objects

Input row (household `i`):
- raw wealth value: `w_{i,t,m}`
- survey weight: `omega_{i,t}`
- race label: `s_i in {white, black}`

## Treatment Definitions

### 1) `positive_only`
Keep only observations with positive value for the selected wealth measure:
- keep row iff `w_{i,t,m} > 0`
- analysis value: `y_{i,t,m} = w_{i,t,m}`

### 2) `shifted_full_sample`
Keep all observations, shift to strictly positive support:
- `c_{t,m} = 1 - min_i w_{i,t,m}` if `min_i w_{i,t,m} <= 0`, else `0`
- `y_{i,t,m} = w_{i,t,m} + c_{t,m}`

## Utility Specification

Normalization used in code:
- `alpha = 0`, `beta = 1`

Utility for epsilon `eps`:
- if `eps = 0`: `U(y) = y`
- if `eps = 1`: `U(y) = ln(y)`
- otherwise: `U(y) = y^(1-eps)/(1-eps)`

Inverse utility:
- if `eps = 0`: `U^{-1}(x) = x`
- if `eps = 1`: `U^{-1}(x) = exp(x)`
- otherwise: `U^{-1}(x) = ((1-eps)*x)^(1/(1-eps))`

## Weighted Components

Group shares:
- `pi_s = (sum_{i:s_i=s} omega_i) / (sum_i omega_i)`

Group expected utility:
- `EU_s = (sum_{i:s_i=s} omega_i * U(y_i)) / (sum_{i:s_i=s} omega_i)`

Overall mean on analysis support:
- `mu = (sum_i omega_i * y_i) / (sum_i omega_i)`

## Welfare Aggregators

Objective model:
- `W^O = sum_{s in S} pi_s * EU_s`

Singleton-prior diagnostic (same as objective):
- `W^A_pi = W^O`

Ambiguity model with `C = Delta(S)`:
- `W^A = min(EU_white, EU_black)`

## EDE and Inequality Indices

EDE levels:
- `w_EDE^O = U^{-1}(W^O)`
- `w_EDE^A = U^{-1}(W^A)`

Indices:
- `I^O = 1 - w_EDE^O / mu`
- `I^A = 1 - w_EDE^A / mu`

## Diagnostic Gap Series

For each year and wealth measure, weighted medians by race:
- `median_white`
- `median_black`

Gap outputs:
- level difference: `gap_diff = median_white - median_black`
- ratio: `gap_ratio = median_white / median_black`

There are two diagnostic variants:
- `all_obs` (no positivity filter)
- `positive_only` (measure-specific positivity filter)

## Where Implemented

Core math:
- `Code/scf_utils.py`
  - `apply_treatment(...)`
  - `utility(...)`
  - `inverse_utility(...)`
  - `compute_measure_record(...)`
  - `compute_gap_diagnostic(..., positive_only=...)`

Exports:
- `Code/measure_workflow.py`
  - `run_measure_exports(...)`
  - `run_gap_diagnostic(...)`

Entry scripts:
- `Code/04_compute_measures_eps0.py`
- `Code/05_compute_measures_eps05.py`
- `Code/06_compute_measures_eps1.py`
- `Code/07_compute_measures_eps2.py`
- `Code/08_compute_measures_eps025.py`
- `Code/09_compute_measures_eps15.py`
- `Code/03_diagnostic_gap_net_vs_gross.py`

## Output Files (Current Convention)

Measure runs write to `Tables/` and `Figures/` using stem:
- `04_measures_eps0_*`
- `05_measures_eps05_*`
- `06_measures_eps1_*`
- `07_measures_eps2_*`
- `08_measures_eps025_*`
- `09_measures_eps15_*`

Diagnostic runs write:
- `Tables/03_gap_diagnostic_all_obs.csv`
- `Tables/03_gap_diagnostic_all_obs_summary.txt`
- `Figures/03_gap_diagnostic_all_obs.(tex|png)`
- `Tables/03_gap_diagnostic_positive_only.csv`
- `Tables/03_gap_diagnostic_positive_only_summary.txt`
- `Figures/03_gap_diagnostic_positive_only.(tex|png)`

## Repro Command

Run only diagnostics:
- `python Code/03_diagnostic_gap_net_vs_gross.py`

Run full pipeline:
- `python Code/1_run_pipeline_01_07.py`
