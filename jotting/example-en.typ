// English example: a complete report on the determination of iron in groundwater.
// It demonstrates the template with a long title, nested headings, lists, numbered
// equations, merged table cells, multi-panel figures, raster images, code blocks,
// footnotes, quotations, callouts, and the page-number switch.

#import "lib.typ": jotting

#show: jotting.with(
  title: [Determination of Trace Iron in Groundwater by 1,10-Phenanthroline Spectrophotometry: Calibration, Interference, and Uncertainty],
  author: [Ya-Cen Lin　B12502045],
  date: [November 8, 2026],
  lang: "en",
  pg-num: false, // off by default; the Chinese example turns this on
)

// Equations are unnumbered by default; enable numbering and cross-reference with @eq:...
#set math.equation(numbering: "(1)")

// Keep units such as mg/L from breaking at the end of a line
#show "mg/L": box

// Document-level extension: a quotation with a thin rule and a visible source
#show quote: it => block(
  width: 100%,
  above: 1.4em,
  below: 1.4em,
  inset: (left: 14pt, right: 4pt),
  stroke: (left: 1pt + luma(150)),
)[
  #it.body
  #if it.attribution != none [
    #v(.4em)
    #text(size: .9em, fill: luma(90))[—#it.attribution]
  ]
]

// Document-level extension: a light-grey callout box
#let note(body) = block(
  body,
  width: 100%,
  above: 1.4em,
  below: 1.4em,
  inset: (x: 12pt, y: 9pt),
  radius: 2pt,
  fill: luma(245),
)

= Purpose

Establish a calibration curve for the Fe(II)–1,10-phenanthroline complex, determine the iron content of a groundwater sample, and evaluate how dilution, filtration, the reagent blank, and cuvette cleanliness affect the result. This single document also demonstrates how the template handles a long title, nested headings, lists, numbered equations, merged table cells, multi-panel figures, code blocks, footnotes, quotations, callouts, and page-number settings.

= Theory

== Beer–Lambert law

In an acetate buffer at pH 3.5–4.5, Fe(II) forms an orange-red complex with 1,10-phenanthroline (phen) that absorbs maximally at $lambda_(max) = 510$ nm. The absorbance $A$ is related to the concentration $c$ by the Beer–Lambert law:

$ A = epsilon b c $ <eq:beer>

where $epsilon$ is the molar absorptivity ($"L mol"^(-1) space "cm"^(-1)$), $b$ is the path length (cm), and $c$ is the concentration ($"mol L"^(-1)$). Once $A$ has been measured for standards of known concentration, a least-squares fit of $A$ against $c$ allows the concentration of an unknown to be read off in reverse. @eq:beer deviates least while $A < 1.5$, so all measurements are kept below that value; samples outside the calibration range are diluted first and the result is multiplied by the dilution factor.

== Complex formation and pH

Colour development can be written as

$ "Fe"^(2+) + 3 "phen" <=> "Fe(phen)"_3^(2+) $ <eq:complex>

Below pH 3, phen is protonated and loses much of its coordinating ability; above pH 6, Fe(III) tends to hydrolyse to iron hydroxide. The acetate buffer both fixes the pH and prevents sharp pH changes from breaking up the complex. Iron(III) in the sample is first reduced with hydroxylamine hydrochloride:

$ 4 "Fe"^(3+) + 2 "NH"_2"OH" -> 4 "Fe"^(2+) + "N"_2"O" + "H"_2"O" + 4 "H"^+ $ <eq:reduce>

Reduction and colour development take place in the same volumetric flask, which avoids transfer losses. The absorbance is stable from 10 to 60 min after colour development and falls slightly after 2 h as the complex slowly decomposes.

= Reagents and instruments

== Reagents

- Iron standard solution, 1000 mg/L (FeCl₃ in 0.1 M HCl), diluted to a 100 mg/L working solution before use
  - Dilute with 0.2% HNO₃ to limit adsorption of iron on glass
  - Prepare the working solution weekly and store it at 4 °C
- 10% (w/v) hydroxylamine hydrochloride
- 0.1% (w/v) 1,10-phenanthroline in ethanol, stored in the dark
- Sodium acetate/acetic acid buffer (pH 4.5, 1 M)
- Deionized water (18.2 MΩ cm)

== Instruments

- Double-beam spectrophotometer (1 nm bandwidth)
- Six 1.0 cm quartz cuvettes
- 50 mL Class A volumetric flasks and 0.45 μm cellulose acetate filters
- Micropipettes (100–1000 μL) and an analytical balance (0.1 mg)

= Method

== Calibration standards

+ Pipette 0, 0.5, 1.0, 2.0, 3.0, and 4.0 mL of the working solution into 50 mL volumetric flasks, corresponding to 0–8 mg/L.
+ Add 1 mL hydroxylamine hydrochloride, 2 mL phenanthroline, and 5 mL buffer in that order, then make up to the mark with deionized water and mix.
  - Mix gently after each reagent so that phen does not precipitate in locally acidic zones.
  - Let the solutions stand for 10 min before measuring, so that colour development is complete.
+ Zero the instrument with the reagent blank and read the absorbance at 510 nm; measure each standard in triplicate and average.

== Sample preparation

+ Filter the sample through a 0.45 μm membrane and discard the first 10 mL#footnote[The first filtrate may leach organic matter from the membrane and contains rinse water from the sampling bottle and tubing.].
+ Dilute 25 mL of the filtrate to 50 mL (twofold) and develop the colour in the same way, in triplicate.
+ Spike another 25 mL portion with 2.00 mg/L iron standard for a recovery test (S-03).

#note[
  *Note*　Samples whose absorbance exceeds 1.2 must be diluted before reading. Record the dilution factor, and keep the diluted concentration in the middle of the calibration range so that regression error is not amplified.
]

#quote(attribution: [APHA, *Standard Methods for the Examination of Water and Wastewater*, 24th ed., Method 3500-Fe B])[
  A calibration curve should include at least five concentration levels, and sample absorbance should fall in its middle range; each batch should include a reagent blank and a check standard.
]

== Workflow

@fig:workflow shows the preparation and measurement sequence used in this report. The diagram is a raster image (PNG); like a vector graphic (SVG) it is included with `image()` and is limited by its native resolution when scaled.

#figure(
  image("images/workflow-en.png", width: 100%),
  caption: [Preparation and measurement sequence for the groundwater samples.],
) <fig:workflow>

= Results

== Absorption spectrum

@fig:spectrum shows the absorption spectra of a 3.00 mg/L iron standard and of the reagent blank between 400 and 620 nm. The complex has a clear maximum at 510 nm, where the blank absorbs only 0.010, so measuring at 510 nm gives the best signal-to-noise ratio.

#figure(
  image("images/spectrum-en.svg", width: 72%),
  caption: [Absorption spectra of the Fe(II)–phen complex and the reagent blank ($c = 3.00$ mg/L, $b = 1.0$ cm).],
) <fig:spectrum>

== Calibration curve

The absorbances and standard deviations of the standards are listed in @tbl:calib. Least-squares regression gives

$ A = 0.2012 c + 0.0025, quad R^2 = 0.9999 $ <eq:fit>

where $c$ is in mg/L. The fitted line and the residuals are shown in @fig:calib: all six residuals lie within the ±0.002 tolerance band, with no visible systematic curvature.

#figure(
  table(
    columns: (1.6fr, 1.2fr, 1fr, 1.3fr),
    align: (center, center, center, center),
    inset: (x: 6pt, y: 4pt),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header(
      [*Concentration $c$ (mg/L)*],
      [*Mean absorbance $A$*],
      [*Standard deviation*],
      [*Relative standard deviation (%)*],
    ),
    table.hline(stroke: 0.5pt),
    [0], [0.002], [0.000], [0.0],
    [1.0], [0.203], [0.001], [0.5],
    [2.0], [0.405], [0.001], [0.2],
    [4.0], [0.809], [0.002], [0.2],
    [6.0], [1.210], [0.002], [0.2],
    [8.0], [1.611], [0.003], [0.2],
    table.hline(stroke: 1pt),
  ),
  caption: [Absorbance of the iron standards ($lambda = 510$ nm, $b = 1.0$ cm, $n = 3$).],
  kind: table,
) <tbl:calib>

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1.6em,
    align(center)[
      #image("images/calibration-en.svg", width: 100%)
      #v(.4em)
      #text(size: .9em)[(a) Calibration and least-squares fit]
    ],
    align(center)[
      #image("images/residual-en.svg", width: 100%)
      #v(.4em)
      #text(size: .9em)[(b) Residuals and the ±0.002 band]
    ],
  ),
  caption: [Calibration curve (a) and residuals (b) for the iron standards. Open circles are means of triplicates, error bars are standard deviations, and the dashed line is the regression result.],
) <fig:calib>

== Sample analysis

The twofold-diluted sample gave $A = 0.384 plus.minus 0.006$ ($n = 3$). Substituting into @eq:fit gives the concentration of the diluted solution:

$ c_"sample" = (0.384 - 0.0025) / 0.2012 = 1.90 "mg/L", $

Multiplying by the dilution factor gives 3.79 mg/L, with a standard deviation of 0.06 mg/L and a relative standard deviation of 1.6%. @tbl:sample summarizes the three samples and the recovery test.

#figure(
  table(
    columns: (1fr, 2.6fr, .9fr, 1.2fr, 1.3fr),
    align: (center, left, center, center, center),
    inset: (x: 6pt, y: 4pt),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header(
      table.cell(colspan: 2)[*Sample and treatment*],
      table.cell(colspan: 3)[*Measurement ($n = 3$)*],
    ),
    table.header(
      [*ID*],
      [*Treatment*],
      [*Dilution*],
      [*Absorbance $A$*],
      [*Concentration $c$ (mg/L)*],
    ),
    table.hline(stroke: 0.5pt),
    [S-01], [Filtered (0.45 μm), unspiked], [2×], [$0.384 plus.minus 0.006$], [$3.79 plus.minus 0.06$],
    [S-02], [Unfiltered, settled for 30 min], [2×], [$0.391 plus.minus 0.011$], [$3.86 plus.minus 0.11$],
    [S-03], [Filtered, spiked with 2.00 mg/L], [2×], [$0.586 plus.minus 0.007$], [$5.80 plus.minus 0.07$],
    table.hline(stroke: 1pt),
  ),
  caption: [Measurements of the groundwater samples and the spike recovery test.],
  kind: table,
) <tbl:sample>

== Recovery and method performance

The spike recovery is calculated with @eq:recovery, where $c_"spiked"$, $c_"sample"$, and $c_"added"$ are the concentrations of the spiked sample, the original sample, and the spike:

$ "Recovery" &= (c_"spiked" - c_"sample") / c_"added" times 100% \
  &= (5.80 - 3.79) / 2.00 times 100% = 100.5% $ <eq:recovery>

The limit of detection, estimated as 3.3 $sigma / S$ ($sigma$ is the blank standard deviation, 0.002, and $S$ is the slope in @eq:fit, 0.2012), is 0.03 mg/L, well below the 0.3 mg/L drinking-water guideline.

= Discussion

== Calibration quality

The slope of $0.2012 space "L mg"^(-1) space "cm"^(-1)$ corresponds to a molar absorptivity of

$ epsilon = 0.2012 times 55.845 = 1.12 times 10^4 space "L mol"^(-1) space "cm"^(-1), $

in agreement with the literature value of $1.1 times 10^4$. The six standards give $R^2 = 0.9999$, and all residuals fall within the ±0.002 band (panel b of @fig:calib), so the calibration is linear from 0 to 8 mg/L.

== Sources of error

The relative standard deviation of the triplicate measurements is 1.6%. The main sources are:

- Fingerprints, bubbles, and meniscus differences on the cuvettes, contributing 0.5% to 1.0% relative error.
- Meniscus reading when making up to volume: ±0.05 mL on a 50 mL flask, that is, 0.1% in concentration.
- Colour-development time and room temperature: the absorbance is stable from 10 to 60 min and falls by about 0.5% after 2 h.
- Sample turbidity: unfiltered S-02 read 1.8% higher than S-01, consistent with particle scattering.

== Comparison with the literature

The iron concentration of 3.79 mg/L is about 13 times the 0.3 mg/L drinking-water guideline. Such levels are common in reducing groundwaters, where Fe(II) oxidizes to Fe(III) on exposure to air and precipitates as iron hydroxide, scaling pipes and equipment. A spike recovery of 100.5% indicates negligible matrix effects, and the 1.8% difference between filtered and unfiltered samples shows a low suspended-solids load. A twofold dilution keeps the absorbance in the middle of the calibration range, a reasonable compromise between sensitivity and linearity.

= Conclusion

The calibration is linear from 0 to 8 mg/L ($R^2 = 0.9999$) with a detection limit of 0.03 mg/L. The groundwater contains $3.8 plus.minus 0.1$ mg/L iron, about 13 times the drinking-water guideline; the spike recovery is 100.5%, so matrix interference is negligible. If used as a drinking-water source, it should first be aerated, oxidized, and filtered.

= References

+ APHA, AWWA, WEF. *Standard Methods for the Examination of Water and Wastewater*, 24th ed., 2023, Method 3500-Fe B.
+ Chen, J.-L., and Huang, Y.-C. “An improved 1,10-phenanthroline method for iron in groundwater.” *Environmental Analytical Chemistry*, 42(3), 2021, 217–228.
+ World Health Organization. *Guidelines for Drinking-water Quality*, 4th ed., 2022. #link("https://www.who.int/publications/i/item/9789240045064")[who.int]

#heading(numbering: none)[Appendix A　Data processing]

The regression is recomputed in Python, and the dilution factor is applied to the sample concentration.

```python
import numpy as np
# Calibration data: concentration (mg/L) and mean absorbance of triplicates
conc = np.array([0.0, 1.0, 2.0, 4.0, 6.0, 8.0])
absb = np.array([0.002, 0.203, 0.405, 0.809, 1.210, 1.611])

slope, intercept = np.polyfit(conc, absb, 1)
pred = slope * conc + intercept
r2 = 1 - ((absb - pred) ** 2).sum() / ((absb - absb.mean()) ** 2).sum()
print(f"A = {slope:.4f} c + {intercept:.4f}, R^2 = {r2:.4f}")
# Sample: twofold dilution, diluted absorbance 0.384
c_diluted = (0.384 - intercept) / slope
print(f"c(diluted) = {c_diluted:.2f} mg/L")
print(f"c(sample)  = {2 * c_diluted:.2f} mg/L")
```

#heading(numbering: none)[Appendix B　Using the template]

The template consists of three files: `lib.typ` defines fonts, sizes, and layout; `example.typ` and `example-en.typ` are the Chinese and English examples. Images live in `images/` and are referenced by relative path, for example `image("images/spectrum-en.svg")`. Compile with

```bash
typst compile example-en.typ
```

```typst
#import "lib.typ": jotting

#show: jotting.with(
  title: [Report title],
  author: [Aaron Chen　B11234567],
  date: [November 8, 2026],
  lang: "en",      // switches leading and spacing
  pg-num: true,    // centered page numbers, off by default
)
```
