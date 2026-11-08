# Jotting

An A4 document template with no cover page, table of contents, or abstract; the document opens with a title, author, and date. It suits short reports and documents.

## Parameters

Here are the parameters:

| Parameter | Default   | Description                                 |
| --------- | --------- | ------------------------------------------- |
| `title`   | `[Title]` | The title                                   |
| `author`  | `[Name]`  | The author's name                           |
| `date`    | `[Date]`  | Displayed after `author` in the same line   |
| `lang`    | `"en"`    | Set to `"zh"` for Chinese                   |
| `pg-num`  | `false`   | When `true`, a centered page number appears |

Note that `lang` will adjust the leading and spacing.

## Usage

```typst
#import "lib.typ": jotting
#show: jotting.with(
  title: [This is an example],
  author: [Aaron Chen],
  date: [November 8, 2026],
)
```

## Customization

Fonts and font sizes are adjustable; to change the styling, edit these two dictionaries:

```typst
#let fonts = (
  body: ("Libertinus Serif", "Songti TC", "Noto Serif TC"),
  head: ("SF Pro Text", "PingFang TC", "Noto Sans TC"),
  title: ("SF Pro Display",),  // prepended to head where used
)

// Font sizes for title, headings, body text, and footer
#let fsize = (title: 20pt, h1: 15pt, h2: 13pt, body: 12pt, footer: 9pt)
```
