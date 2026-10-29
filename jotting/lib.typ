#import "@preview/codly:2.0.0" as codly

#let fonts = (
  body: (
    "Libertinus Serif",
    "Songti TC",
    "Noto Serif TC",
    "Noto Serif CJK TC",
  ),
  head: (
    "SF Pro Text",
    "PingFang TC",
    "Noto Sans TC",
    "Noto Sans CJK TC",
  ),
  title: ("SF Pro Display",),
)

#let fsize = (
  title: 20pt,
  h1: 15pt,
  h2: 13pt,
  body: 12pt,
  footer: 9pt,
)

#let report(
  title: [報告標題],
  author: [姓名　學號],
  date: [日期],
  lang: "en",
  page-number: false,
  body,
) = {
  set list(indent: .5em)
  set enum(indent: .5em)
  set heading(numbering: "1.1")

  let footer = if page-number {
    set text(fill: luma(120), font: fonts.head, size: fsize.footer)
    context { align(center)[#counter(page).display()] }
  } else { none }

  set text(lang: lang)
  set text(font: fonts.body, size: fsize.body)
  set text(bottom-edge: -.2em, top-edge: .8em)
  set page(footer: footer, paper: "a4")

  let leading = if lang == "en" { .5 } else { .6 } * fsize.body
  set par(leading: leading, justify: true, spacing: 2.5 * leading)

  show heading: set text(font: fonts.head, weight: "bold")
  show heading.where(level: 1): it => block(
    above: 1.5 * fsize.h1,
    below: 1.1 * leading,
    sticky: true,
    text(size: fsize.h1, it),
  )
  show heading.where(level: 2): it => block(
    above: 1.4 * fsize.h2,
    below: 1.1 * leading,
    sticky: true,
    text(size: fsize.h2, it),
  )

  show figure: set text(size: .9em)
  show figure: set par(leading: .9 * leading, justify: false)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: it => block(above: 1em, below: 1em, it)

  show: codly.theme("one-light")
  show: codly.set_(lang-position: none, number-enabled: false)
  show: codly.set_(leading: .2em, padding: (bottom: .3em, top: .2em, x: .4em))
  show raw.where(block: true): codly.new

  // The title block
  block(above: 0pt, below: 0pt, width: 100%)[#{
    block(above: 0pt, below: 0pt, width: 100%)[#{
      set text(
        font: fonts.title + fonts.head,
        size: fsize.title,
        weight: "bold",
      )
      title
    }]

    block(above: 1.5 * leading, below: 0pt, rect(fill: black, height: 1pt, width: 100%))
    block(above: 1.5 * leading, below: 0pt, width: 100%)[#author · #date]
    v(leading)
  }]

  body
}
