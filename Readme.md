# Text Analysis of FOMC Statements using NLP

Sentiment (tone) analysis and topic classification of Federal Open Market Committee (FOMC) statements using natural language processing and machine learning. The project scores the tone of each statement with a finance-tuned language model, explores the text through EDA, and classifies statements across key monetary-policy themes using SVM and CNN models.

## Overview

The project is organized into three stages:

1. **Tone scoring** — measure the sentiment of each FOMC statement using FinBERT.
2. **Exploratory data analysis (EDA)** — extract, clean, and visualize the statement corpus.
3. **Classification** — manually annotate statements across policy themes, then train and evaluate SVM and CNN classifiers.

## Repository Structure

### 1. FOMC Tone (FinBERT)

Scores each statement's positive, negative, and neutral weights and derives an overall tone.

| File | Description |
|------|-------------|
| `1.FinBert_Tone_Code.ipynb` / `.pdf` | Colab notebook (Python) that runs FinBERT on the statements |
| `1.FOMC_tone.csv` | Output: date, statement, positive / negative / neutral weights, tone |
| `1.FOMC_tone_EDA.xlsx` | Tone data prepared for EDA |

### 2. Exploratory Data Analysis

Statement extraction and visualizations, produced in **R (`Rcode1`, Section 2)**. Generates Figures 1–6.

| File | Description |
|------|-------------|
| `2.reports-in` | Extracted corpus: year, date, link, statement, statement length |
| `2.words_Freq.csv` | Word frequencies: year, word, total, rank |
| `2.Words_Percent` | Word frequencies with percentage (used for Figure 6) |
| `2.EDA` | Three sheets — Pareto (Figure 2), frequency-percentage calc, Figure 3 |
| `2.Stmt-wise inflation` | Data behind Figure 4 |

**Figures:** Figure 1 & 5 (extraction/EDA), Figure 2 (Pareto), Figure 3, Figure 4 (inflation), Figure 6 (word percentages).

### 3. Classification

Manual annotation followed by machine-learning classification across policy themes.

**Annotation & setup**

| File | Description |
|------|-------------|
| `3.Process of Manual annotation.docx` | Annotation methodology and final results |
| `3.FOMC_Class` | Manual labels: Economic growth, Employment growth, Inflation, Medium-term rate, Policy rate |
| `Classification data/` | Five datasets built for classification (`Rcode1`, Section 3) |

**Method**

Statements are pre-processed and converted into term weights. Because the resulting matrix is sparse, ~60% of the sparsest columns are dropped, leaving **140 weighted feature columns**. Each column from `3.FOMC_Class` is used in turn as the target variable, and two algorithms are applied:

- **Support Vector Machine** — `3.Classification Machine Learning`
- **Convolutional Neural Network** — `3.Classification CNN`

Five datasets are classified with both methods; results are reported in `3.Process of Manual annotation.docx`.

**Figures (from `Rcode1`, Section 3):** Figure 7 (classification by FOMC features), Figure 8 (correlation of FOMC features).

**Additional report:** `FOMC Statements EDA` — EDA write-up.

## Methods & Tools

- **FinBERT** — finance-domain sentiment/tone scoring
- **Python** (Colab) — tone extraction
- **R** — text extraction, EDA, visualization, classification pipeline
- **Support Vector Machine (SVM)** and **Convolutional Neural Network (CNN)** — theme classification

## Data

Text is sourced from published FOMC statements (see the `link` column in `2.reports-in`).
