# jotting

A4、無封面、無目錄、無摘要的課堂報告樣板。第一頁第一個元素就是標題。
頁碼預設關閉，需要時用 `page-number: true` 開啟，從 1 開始。使用
Typst 0.15.1 編譯。模板入口是 `lib.typ`。程式碼區塊由 codly 處理，
預設是灰底、行號、無框線的樣式。

## 檔案

| 檔案 | 用途 |
|---|---|
| `lib.typ` | 模板入口，只含版面設定與 codly 設定，沒有正文 |
| `example.typ` | 可編譯的中文實驗結報範例（3 頁） |
| `example.pdf` | 範例編譯結果 |
| `figures/calibration.svg` | 範例用的檢量線圖 |

範例是 3 頁：第 1 頁在檢量線公式後結束；第 2 頁是表格、圖與討論；
第 3 頁是結論與附錄的迴歸程式。這是內文、程式碼與圖表放不下的自然
結果，不是固定版面的一部分。

## 編譯

以下指令都在 `jotting/` 目錄執行：

```sh
typst compile example.typ example.pdf
```

第一次編譯會自動下載 `@preview/codly:2.0.0` 與它的相依套件
（`elembic`）。codly 需要 Typst 0.15.0 以上；本模板以 0.15.1 測試。

## 使用方式

```typst
#import "lib.typ": report

#show: report.with(
  title: [報告標題],
  author: [王小明　B11234567],
  date: [2026 年 10 月 25 日],
  lang: "zh",
)

= 第一節
正文……

== 小節
正文……
```

從專案根目錄使用時，import 路徑改成 `jotting/lib.typ`。

標題、分隔線、作者行都由樣板產生；之後的第一個元素通常是一級標題。
作者行之後是 `v(leading)` 加上第一個一級標題自己的 `above`（1.5 ×
`fsize.h1`），樣板沒有另外的 `rule-below`。相鄰 block 的間距在 Typst
會取較大值，不會把 `below` 和 `above` 直接相加。

全篇沒有頁首；頁碼預設關閉。要頁碼就在 `report.with(...)` 加上
`page-number: true`，頁尾會置中顯示 9pt、`luma(120)` 的頁碼。
`title` 只出現在第一頁的標題區。

樣板沒有開啟公式編號，所以範例用「代入檢量線」這類文字指涉公式，
不依賴 `@eq:...`。若需要 `(1)`、`(2)`，在內文開頭加
`#set math.equation(numbering: "(1)")`，在公式後加 `<eq:...>` 標籤，
再以 `@eq:...` 引用。

`lang` 預設是 `"en"`。中文文件要寫 `lang: "zh"`，行距與圖表分隔
字元才會用中文設定；英文可以省略，但範例仍明寫：

```typst
#show: report.with(
  title: [Trace Iron in Groundwater by~Spectrophotometry],
  author: [Alex Chen · B12502045],
  date: [October 21, 2026],
  lang: "en",
)
```

`author` 是一個完整的內容欄位，姓名、學號或兩者都由使用者自行填寫，
樣板不拆欄位，也不強制格式。作者與 `date` 會以「author · date」放在
分隔線下方同一行；多位作者請自行用逗號、頓號或 `·` 分隔，樣板不
解析名單，太長就自然換行。圖表說明的分隔字元沿用 Typst 預設值，
依 `lang` 自動選擇（中文 `表 1　…`、英文 `Table 1: …`）。表格說明
固定在表格上方，圖片說明維持在下方；其餘結構相同，行距仍依 `lang`
不同。

## 程式碼區塊

`lib.typ` 已經載入 codly，正文直接寫 fenced code block 就會套用樣式，
不需要在文件裡另外 `#import` 或 `#show`：

````typst
```python
def calibration(xs, ys):
    return sum(xs) / len(xs), sum(ys) / len(ys)
```
````

行內程式碼維持 Typst 原生的等寬字體、顏色與 0.8em 字級，
不會變成有行號的區塊。

目前的區塊樣式是 codly 的 `clean` 主題，只另外指定灰底；水平列
內距、無框線、無圓角、無語言與檔名標籤都沿用 `clean` / codly 的
預設值。垂直行距另外用 `leading` 收緊（codly 預設的垂直 inset
`.32em` 太鬆）。左側保留行號。要改樣式就動 `lib.typ` 這幾行：

```typst
show: codly.theme("clean", fill: luma(247))
show: codly.set_(lang-position: none, file-position: none, leading: .05em)
show raw.where(block: true): codly.new
```

例如把 `theme(...)` 的 `fill` 改成 `none` 就沒有灰底；把
`lang-position` 改成 `top + right` 就會顯示語言標籤（語言名稱與圖示
需另外載入 `@preview/codly-languages`）。需要編號與說明時，把區塊
放進 `figure`，codly 會沿用外層 figure 的標籤：

```typst
#figure(
  caption: [迴歸程式],
  raw("slope, intercept = np.polyfit(c, A, 1)", lang: "python", block: true),
)
```

範例的附錄標題寫成 `#heading(numbering: none)[附錄：迴歸程式]`，
這樣就不會被 `1.1` 的自動編號影響。

## 版面數字

| 數值 | 目前值 | 說明 |
|---|---|---|
| 標題 | 20pt 粗體 | 左對齊，獨占全寬 |
| 一級標題 | 15pt 粗體 | 自動編號，第一個標題在作者行之後 |
| 二級標題 | 13pt 粗體 | 自動編號 1.1 |
| 正文 | 12pt | 中文 leading 0.6em（行高 1.6 倍）、英文 0.5em（行高 1.5 倍） |
| 段距 | 2.5 × leading | 中文 18pt（1.5em）、英文 15pt（1.25em） |
| 分隔線 | 1pt | 與版面同寬，高度寫死 |
| 標題到線 | 1.5 × leading | 中文 10.8pt、英文 9pt；從標題行盒底算起 |
| 線到作者行 | 1.5 × leading | 中文 10.8pt、英文 9pt；作者行另有 0.8em `top-edge` |
| 作者行 | 12pt | 與正文同字體、同顏色、左對齊 |
| 作者行到第一個一級標題 | `v(leading)` + 1.5 × `fsize.h1` | 中文 29.7pt、英文 28.5pt（作者行盒底到標題行盒頂） |
| 一級標題前後 | 22.5pt / 7.92pt（中文）、6.6pt（英文） | 1.5 × `fsize.h1` / 1.1 × leading |
| 二級標題前後 | 18.2pt / 7.92pt（中文）、6.6pt（英文） | 1.4 × `fsize.h2` / 1.1 × leading |
| 圖表說明 | 10.8pt（0.9em） | 不齊行；表格說明在上、圖片說明在下 |
| 圖表區塊 | 上下各 1em | 表格與圖片皆同 |
| 程式碼 | 9.6pt（0.8em） | 等寬字體；左側行號，無語言與檔名標籤 |
| 程式碼區塊 | 灰底 `luma(247)` | 無框線、無圓角；水平內距用 codly 預設值，垂直 `leading` .05em |
| 頁邊 | Typst 預設 | 未指定；A4 四邊 2.5cm |

範例實測：標題基線 86.87pt、線 101.67–102.67pt、作者基線
123.07pt、第一個一級標題基線 167.17pt。標題獨占全寬後，範例的標題
剛好是一行；更長的標題會自然折行。

Typst 沒有 `line-height`，`par.leading` 是行與行之間的**空隙**。
標題不另外設定行盒或 `par`，直接沿用正文：`top-edge: 0.8em`、
`bottom-edge: -.2em`，行盒高 1em，行距為正文 leading（中文
0.6 × `fsize.body` = 7.2pt，英文 0.5 × `fsize.body` = 6pt）。
20pt 標題的基線到基線因此是 1em + 0.36em = 1.36em（中文
27.2pt）；英文是 1em + 0.3em = 1.3em（26pt）。分隔線到標題
最後一行基線的距離則是 0.2em + 1.5 × leading：中文 4 + 10.8 =
14.8pt，英文 4 + 9 = 13pt。

## 可調數值與注意事項

- **線的粗細**：直接寫死 1pt（`height: 1pt`）。改粗細不影響上下間距。
- **標題字級** `fsize.title`：目前 20pt（原始硬性規格 24pt）。標題
  現在獨占全寬，20pt 下範例的標題剛好一行；再小會和一級標題
  拉不開，再大則長標題容易折行，標題區會變高。標題不另外設定 `par`，
  行盒與行距都沿用正文；20pt 下中文行距是 1.36 倍，兩行以上不會擠在
  一起。標題區的間距（標題到線、線到作者、作者到第一節的 `v()`）都以
  正文 leading 為基準，不是 `fsize.title`；改標題字級不會等比例放大
  這三段間距。
- **長標題折行**：中文標題在 20pt 下約 22 字折行。Typst 會按 Unicode
  規則斷行，可能把「微量」這類詞拆到兩行；要指定斷點就在標題裡手動
  加 `\`，例如 `title: [……自來水中的\ 微量鐵含量]`。
- **一級標題字級** `fsize.h1`：13–16pt。作者行是 12pt，一級標題
  仍要明顯大於正文（現在 15 : 12），否則第一節會跟作者行黏在一起。
- **章節標題間距**：`h1` 的 `above` 是 1.5 × `fsize.h1`、`below` 是
  1.1 × leading；`h2` 的 `above` 是 1.4 × `fsize.h2`、`below` 也是
  1.1 × leading。相鄰標題的 `below` 與下一個標題的 `above` 會取較大
  值，不會相加。
- **線的上方間距**：1.5 × leading（中文 10.8pt、英文 9pt），從標題
  行盒底部算起；因為 `bottom-edge` 是 -.2em，實際離最後一行基線是
  14.8pt（中文）或 13pt（英文）。線屬於標題，要動的話作者行間距也
  要一起看。
- **線到作者行**：1.5 × leading（中文 10.8pt、英文 9pt）。作者行本身
  有 0.8em 的 `top-edge`，所以視覺間距會比數值再鬆一點。
- **作者行到第一節**：`v(leading)` 加上第一個一級標題的 `above`
  （中文 29.7pt、英文 28.5pt，從作者行盒底到標題行盒頂）。樣板沒有
  獨立的 `rule-below`；要加大距離就調 `v(leading)` 或一級標題的
  `above`，兩者不要重複加。
- **正文字級與行距**：目前 12pt；中文 leading 0.6em（行高 1.6 倍）、
  英文 0.5em（行高 1.5 倍）。原始硬性規格是 10–10.5pt；這個版本依後續
  需求調到 12pt，若作業以原規格評分，把 `fsize.body` 改回 10.5pt
  即可。改 `fsize.body` 時要一起看 `fsize.h2`：二級標題必須明顯大於
  正文（現在 13 : 12），否則 12pt 的粗體二級標題會跟正文混在一起。
  正文固定了 `top-edge: 0.8em`、`bottom-edge: -0.2em`，所以行盒固定
  1em，行高 = leading + 1em，不會因為中英文字體 metrics 不同而忽大
  忽小。`spacing: 2.5 * leading`，段距是行距的 2.5 倍：中文 1.5em、
  英文 1.25em。因為標題區間距也用 leading 計算，改 `fsize.body` 會
  同時改變段距與標題區間距。
- **圖表**：說明文字與表格內文都是正文的 0.9em，行距是 0.9 ×
  leading，且不齊行；表格說明固定在表格上方。表格與圖片區塊上下各
  留 1em。
- **程式碼**：字級沿用 Typst raw 的預設 0.8em（9.6pt），樣板不另外
  設定。放進 `figure` 時，圖表的 0.9em 會再乘上去，程式碼會變成
  8.64pt（0.72em）；不希望縮小的話，在內文自己覆寫 raw 字級。區塊用
  codly 的 `clean` 主題，只把底色改成 `luma(247)`；水平內距、框線、
  圓角、語言與檔名標籤都用 codly 預設值。垂直方向另外用
  `leading: .05em` 收緊，因為 codly 預設的垂直 inset 是 `.32em`，
  行距會到 20.7pt；現在實測約 13pt。行號預設開啟，由 codly 依序
  編號。灰底只鋪在程式碼列，區塊上下仍用一般段距，沒有另外包
  `block`。要恢復 codly 的預設外觀，把 `lib.typ` 裡的
  `codly.theme(...)` 那行拿掉即可（`codly.set_` 只是隱藏標籤與調整
  leading）。

## 字體與字級

字體集中在 `fonts`，字級集中在 `fsize`，改樣式只要動這兩個字典：

```typst
#let fonts = (
  body: ("Libertinus Serif", "Songti TC", "Noto Serif TC", "Noto Serif CJK TC"),
  head: ("SF Pro Text", "PingFang TC", "Noto Sans TC", "Noto Sans CJK TC"),
  title: ("SF Pro Display",),   // 使用時接在 head 前面
)

#let fsize = (
  title: 20pt, h1: 15pt, h2: 13pt, body: 12pt,
  footer: 9pt,
)
```

字體清單由左至右嘗試，缺字或字體不存在就往下退，不會編譯失敗：

- 正文、作者與日期：Libertinus Serif → Songti TC → Noto Serif TC →
  Noto Serif CJK TC
- 各級標題、頁尾：SF Pro Text → PingFang TC →
  Noto Sans TC → Noto Sans CJK TC
- 報告標題（20pt）：SF Pro Display → head 那整串

`fonts.title` 只放 Display，實際使用時寫成 `fonts.title + fonts.head`，
這樣 Display 沒有的字（中文、缺字）會自動退回 head。20pt 正好是
Apple 的分界（小於 20pt 用 Text、20pt 以上用 Display），所以標題
取 Display，同一串英文才不會被 Text 的字距撐成多一行。

Libertinus Serif 不是 macOS 內建字體，這台機器裝在
`~/Library/Fonts/`。它的 x-height（0.433em）比一般正文襯線體小，
同樣 12pt 下拉丁會比中文小一級左右，讀起來接近中文排版常見的
「西文略小」慣例；不是掉字或設錯。換到沒有這款字體的機器時，
拉丁會由 Songti TC 接手。

**非 macOS 的情況**：SF Pro 與 PingFang 都會被跳過，標題落到
`Noto Sans TC` 或 `Noto Sans CJK TC`（這兩個家族本身就含拉丁），
正文落到 Noto Serif CJK，不會缺字，也不會編譯失敗。Noto Sans CJK
本身沒有 Display 版本（拉丁的 `Noto Sans Display` 有，但不含中文），
不過 20pt 還不到非用不可的程度；真的要講究，裝 `Noto Sans Display`
再把它排進 `fonts.title` 最前面，中文仍會由 Noto Sans CJK 接手。
Typst 對找不到的家族只給 warning，最後一定有嵌入的預設字體接手。

這台機器實際用到的是 Libertinus Serif（拉丁）＋ Songti TC（中文）、
SF Pro Text（各級標題、頁尾）、SF Pro Display（報告標題），
數學用 NewCM Math。`Noto Serif TC` 與 `Noto Sans TC` 是
Google Fonts 的家族名稱，這台機器只裝了 CJK 版，所以編譯時會出現
這兩條 `unknown font family` 的 warning；那是正常的，換到裝有
Noto TC 的機器就會自動接手。

## 自查結果

- [x] 全篇沒有封面、沒有頁首；第一頁第一個元素是標題。
- [x] 沒有目錄、沒有摘要、沒有 front matter。
- [x] 標題左對齊、獨占全寬；作者與日期在分隔線下方、左對齊、
      12pt、與正文同字體與顏色。
- [x] 分隔線 1pt、100% 寬；標題行盒底到線、線到作者行都是 1.5 × leading
      （中文 10.8pt、英文 9pt）。
- [x] 作者行後接 `v(leading)` 與第一個一級標題的 `above`；沒有獨立的
      `rule-below`，相鄰 block 間距取較大值，不另外疊加。
- [x] 沒有頁首；頁碼預設關閉，`page-number: true` 時頁尾置中顯示。
- [x] 正文 12pt、中文 leading 0.6em（行高 1.6 倍）/ 英文 0.5em（行高
      1.5 倍）、段距 2.5 × leading、左右對齊（justify）；圖說與表格
      維持不齊行。
- [x] 標題沿用正文的行盒與行距，只換字體、字級與粗細。
- [x] 範例 3 頁，含表格、圖、條列清單、公式，以及附錄的程式碼區塊。
- [x] 程式碼區塊用 codly 排版：灰底、行號、無框線與語言標籤；
      行內程式碼維持 0.8em，不加行號。
- [x] 範例的標題為一行；更長的標題會自然折行，行距沿用正文
      （中文 1.36 倍），不與分隔線或作者行重疊。
- [x] 字體全部嵌入，沒有缺字方塊。
