# Papyrus

Typst 排版模板集。每個模板各自一個資料夾，入口固定為
`<模板>/lib.typ`，資料夾內附一份 `example` 與說明。

| 模板 | 入口 | 說明 |
|---|---|---|
| [jotting](jotting/) | [`jotting/lib.typ`](jotting/lib.typ) | A4 課堂報告；無封面、目錄、摘要，頁碼可選；程式碼區塊用 codly |

## 使用

```typst
#import "jotting/lib.typ": report

#show: report.with(
  title: [報告標題],
  author: [王小明　B11234567],
  date: [2026 年 10 月 25 日],
  lang: "zh",
)
```

各模板的參數、版面數字與注意事項，見資料夾內的 `README.md`。
