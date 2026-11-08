// 中文範例：一份完整的地下水中鐵含量測定報告。
// 示範範本在長標題、多層標題、巢狀清單、方程式編號、合併儲存格、
// 多面板圖片、光柵圖片、程式碼區塊、註腳、引文、提示方塊與頁碼下的表現。

#import "lib.typ": jotting

#show: jotting.with(
  // `box` 讓「地下水中」不被拆行；CJK 文字預設可在任何字元間換行
  title: [以鄰二氮菲分光光度法測定#box[地下水中]的微量鐵含量：檢量線、干擾與不確定度評估],
  author: [林亞岑　B12502045],
  date: [2026 年 11 月 8 日],
  lang: "zh",
  pg-num: true, // 預設為 false；開啟後頁尾置中顯示頁碼
)

// 方程式預設不編號，此處開啟並以 @eq:... 交叉引用
#set math.equation(numbering: "(1)")

// 讓 mg/L 這類單位不在行末被拆開
#show "mg/L": box

// 文件層級的延伸樣式：左側細線的引文，並顯示出處
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
    #text(size: .9em, fill: luma(90))[——#it.attribution]
  ]
]

// 文件層級的延伸樣式：淺灰底的提示方塊
#let note(body) = block(
  body,
  width: 100%,
  above: 1.4em,
  below: 1.4em,
  inset: (x: 12pt, y: 9pt),
  radius: 2pt,
  fill: luma(245),
)

= 實驗目的

建立鐵(II)–鄰二氮菲錯合物的檢量線，測定地下水樣品的鐵含量，並評估稀釋、過濾、試劑空白與比色管清潔度對結果的影響。本報告以單一文件示範範本在長標題、多層標題、巢狀清單、方程式、合併儲存格、多面板圖片、程式碼與頁碼等情況下的排版表現。

= 實驗原理

== Beer–Lambert 定律

在 pH 3.5 至 4.5 的醋酸鹽緩衝液中，Fe(II) 與鄰二氮菲（1,10-phenanthroline，簡稱 phen）生成橘紅色錯合物，最大吸收波長 $lambda_(max) = 510$ nm。吸光度 $A$ 與濃度 $c$ 的關係服從比爾–朗伯定律：

$ A = epsilon b c $ <eq:beer>

其中 $epsilon$ 為莫耳吸光係數（$"L mol"^(-1) space "cm"^(-1)$），$b$ 為光徑（cm），$c$ 為濃度（$"mol L"^(-1)$）。以已知濃度的標準溶液測得 $A$ 後，對 $c$ 作最小平方迴歸，即可由未知樣品的 $A$ 反算濃度。@eq:beer 在 $A < 1.5$ 時偏離最小，故所有測量均控制在此範圍內；樣品若超出檢量線範圍，應先稀釋再測，並將結果乘回稀釋倍率。

== 錯合物生成與 pH 條件

顯色反應可寫為

$ "Fe"^(2+) + 3 "phen" <=> "Fe(phen)"_3^(2+) $ <eq:complex>

pH 低於 3 時，phen 被質子化而降低配位能力；pH 高於 6 時，Fe(III) 易水解為氫氧化鐵沉澱。醋酸鹽緩衝液除了維持 pH，也可避免酸鹼度劇烈變化破壞錯合物。水樣中的 Fe(III) 先以鹽酸羥胺還原為 Fe(II)：

$ 4 "Fe"^(3+) + 2 "NH"_2"OH" -> 4 "Fe"^(2+) + "N"_2"O" + "H"_2"O" + 4 "H"^+ $ <eq:reduce>

還原與顯色在同一容量瓶中完成，可減少轉移損失；顯色後 10 至 60 分鐘內吸光度穩定，超過 2 小時則因錯合物緩慢分解而略為下降。

= 試劑與儀器

== 試劑

- 鐵標準溶液 1000 mg/L（FeCl₃ 溶於 0.1 M HCl），使用前稀釋為 100 mg/L 工作液
  - 以 0.2% HNO₃ 稀釋，避免鐵吸附於玻璃器壁
  - 工作液每週配製，存放於 4 °C
- 10%（w/v）鹽酸羥胺還原劑
- 0.1%（w/v）鄰二氮菲乙醇溶液，避光保存
- 醋酸鈉／醋酸緩衝液（pH 4.5，1 M）
- 去離子水（18.2 MΩ cm）

== 儀器

- 雙光束分光光度計（頻寬 1 nm）
- 1.0 cm 石英比色管 6 支
- 50 mL A 級容量瓶、0.45 μm 醋酸纖維濾膜
- 微量吸管（100–1000 μL）與分析天平（0.1 mg）

= 實驗方法

== 檢量線配製

+ 取 0、0.5、1.0、2.0、3.0、4.0 mL 工作液，分別置於 50 mL 容量瓶，對應濃度 0 至 8 mg/L。
+ 依序加入 1 mL 鹽酸羥胺、2 mL 鄰二氮菲與 5 mL 緩衝液，以去離子水定容至刻度後搖勻。
  - 每加一試劑後緩慢搖勻，避免局部過酸使 phen 析出。
  - 定容後靜置 10 分鐘，使顯色完全再行測量。
+ 以試劑空白校正零點，於 510 nm 測量吸光度；每點重複三次，取平均值。

== 樣品前處理

+ 水樣以 0.45 μm 濾膜過濾，棄去初濾液 10 mL#footnote[初濾液可能溶出濾膜上的有機物，且含採樣瓶與管路之沖洗水。]。
+ 取 25 mL 濾液稀釋至 50 mL（稀釋 2 倍），同法顯色並測量三次。
+ 另取 25 mL 濾液加入 2.00 mg/L 鐵標準品，作為加標回收試驗（S-03）。

#note[
  *注意*　吸光度超過 1.2 的樣品應先稀釋再測；稀釋倍率須計入結果，且稀釋後的濃度仍應落於檢量線中段，以免迴歸誤差被放大。
]

#quote(attribution: [APHA, *Standard Methods for the Examination of Water and Wastewater*, 24th ed., Method 3500-Fe B])[
  檢量線至少應涵蓋五個濃度點，樣品吸光度宜落於檢量線中段；每批次分析應包含試劑空白與查核樣品。
]

== 前處理流程

@fig:workflow 為本報告採用的前處理與測量流程。流程以點陣圖（PNG）呈現，與向量圖（SVG）同樣可直接以 `image()` 引用，縮放時以原圖解析度為限。

#figure(
  image("images/workflow-zh.png", width: 100%),
  caption: [地下水樣品之前處理與測量流程。],
) <fig:workflow>

= 結果

== 吸收光譜

@fig:spectrum 為 3.00 mg/L 鐵標準溶液與試劑空白在 400 至 620 nm 的吸收光譜。錯合物在 510 nm 有明顯吸收峰，空白在此波長僅 0.010，故以 510 nm 作為測量波長可獲得最大訊噪比。

#figure(
  image("images/spectrum-zh.svg", width: 72%),
  caption: [Fe(II)–phen 錯合物與試劑空白之吸收光譜（$c = 3.00$ mg/L，$b = 1.0$ cm）。],
) <fig:spectrum>

== 檢量線

標準溶液之吸光度與標準差列於@tbl:calib，以最小平方迴歸求得

$ A = 0.2012 c + 0.0025, quad R^2 = 0.9999 $ <eq:fit>

其中 $c$ 的單位為 mg/L。迴歸曲線與各濃度點的殘差見@fig:calib，六個殘差均落在 ±0.002 的容許帶內，未見明顯的系統性彎曲。

#figure(
  table(
    columns: (1.6fr, 1.2fr, 1fr, 1.3fr),
    align: (center, center, center, center),
    inset: (x: 6pt, y: 4pt),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header(
      [*濃度 $c$（mg/L）*],
      [*平均吸光度 $A$*],
      [*標準差*],
      [*相對標準差（%）*],
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
  caption: [鐵標準溶液之吸光度（$lambda = 510$ nm，$b = 1.0$ cm，$n = 3$）。],
  kind: table,
) <tbl:calib>

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1.6em,
    align(center)[
      #image("images/calibration-zh.svg", width: 100%)
      #v(.4em)
      #text(size: .9em)[（a）檢量線與最小平方迴歸]
    ],
    align(center)[
      #image("images/residual-zh.svg", width: 100%)
      #v(.4em)
      #text(size: .9em)[（b）殘差與 ±0.002 容許帶]
    ],
  ),
  caption: [鐵標準溶液之檢量線（a）與殘差（b）。空心圓為三次測量平均值，誤差線為標準差，虛線為迴歸結果。],
) <fig:calib>

== 樣品測定

樣品經二倍稀釋後測得 $A = 0.384 plus.minus 0.006$（$n = 3$），代入@eq:fit 得稀釋液濃度

$ c_"樣品" = (0.384 - 0.0025) / 0.2012 = 1.90 "mg/L", $

乘回稀釋倍率後為 3.79 mg/L，三次重複的標準差為 0.06 mg/L、相對標準差 1.6%。@tbl:sample 彙整三件樣品的結果與加標回收試驗。

#figure(
  table(
    columns: (1fr, 2.6fr, .9fr, 1.2fr, 1.3fr),
    align: (center, left, center, center, center),
    inset: (x: 6pt, y: 4pt),
    stroke: none,
    table.hline(stroke: 1pt),
    table.header(
      table.cell(colspan: 2)[*樣品與前處理*],
      table.cell(colspan: 3)[*測量結果（$n = 3$）*],
    ),
    table.header(
      [*編號*],
      [*處理方式*],
      [*稀釋倍率*],
      [*吸光度 $A$*],
      [*濃度 $c$（mg/L）*],
    ),
    table.hline(stroke: 0.5pt),
    [S-01], [0.45 μm 過濾，未加標], [2×], [$0.384 plus.minus 0.006$], [$3.79 plus.minus 0.06$],
    [S-02], [未過濾，靜置 30 分鐘], [2×], [$0.391 plus.minus 0.011$], [$3.86 plus.minus 0.11$],
    [S-03], [0.45 μm 過濾，加標 2.00 mg/L], [2×], [$0.586 plus.minus 0.007$], [$5.80 plus.minus 0.07$],
    table.hline(stroke: 1pt),
  ),
  caption: [地下水樣品之測量結果與加標回收試驗。],
  kind: table,
) <tbl:sample>

== 回收率與方法性能

加標回收率以@eq:recovery 計算，其中 $c_"加標"$、$c_"原樣"$ 與 $c_"添加"$ 分別為加標樣品、原樣品與添加量之濃度：

$ "回收率" &= (c_"加標" - c_"原樣") / c_"添加" times 100% \
  &= (5.80 - 3.79) / 2.00 times 100% = 100.5% $ <eq:recovery>

檢出極限以 3.3 $sigma / S$ 估算（$sigma$ 為空白標準差 0.002，$S$ 為@eq:fit 的斜率 0.2012），得 0.03 mg/L，遠低於飲用水水質標準 0.3 mg/L。

= 討論

== 檢量線品質

檢量線的斜率為 $0.2012 space "L mg"^(-1) space "cm"^(-1)$，換算莫耳吸光係數

$ epsilon = 0.2012 times 55.845 = 1.12 times 10^4 space "L mol"^(-1) space "cm"^(-1), $

與文獻值 $1.1 times 10^4$ 相符，顯示錯合物組成與文獻一致。六個濃度點的 $R^2$ 為 0.9999，殘差均落在 ±0.002 的容許帶內（@fig:calib 的 b 面板），檢量線在 0 至 8 mg/L 間線性良好。以 0.002 的空白標準差估算，檢出極限為 0.03 mg/L，足以測定飲用水標準附近的濃度。

== 誤差來源

樣品三次測量的相對標準差為 1.6%，主要誤差來源如下：

- 比色管外壁的指紋、氣泡與液面高度差異，估計貢獻 0.5% 至 1.0% 的相對誤差。
- 定容讀數的凹液面判斷，50 mL 容量瓶約有 ±0.05 mL 的變異，相當於 0.1% 的濃度誤差。
- 顯色時間與室溫：10 至 60 分鐘內吸光度穩定，超過 2 小時則下降約 0.5%。
- 樣品濁度：未過濾樣品 S-02 的結果較 S-01 高 1.8%，與懸浮顆粒的散射有關。

== 與文獻比較

地下水鐵濃度 3.79 mg/L，約為飲用水水質標準 0.3 mg/L 的 13 倍；此濃度在還原性地下水中常見，若抽取後接觸空氣，Fe(II) 會氧化為 Fe(III) 並形成氫氧化鐵沉澱，造成管線與設備結垢。加標回收率 100.5%，顯示基質效應可忽略；未過濾與過濾樣品的差異僅 1.8%，說明本樣品的懸浮固體含量不高。以稀釋 2 倍進行測定，可將吸光度控制在檢量線中段，是兼顧靈敏度與線性的合理選擇。

= 結論

檢量線在 0 至 8 mg/L 間線性良好（$R^2 = 0.9999$），檢出極限 0.03 mg/L。地下水鐵濃度為 $3.8 plus.minus 0.1$ mg/L，約為飲用水標準的 13 倍；加標回收率 100.5%，基質干擾可忽略。若作為飲用水源，需經曝氣、氧化與過濾處理後再使用。

= 參考文獻

+ APHA, AWWA, WEF. *Standard Methods for the Examination of Water and Wastewater*, 24th ed. Washington, DC: American Public Health Association, 2023, Method 3500-Fe B.
+ 陳建良、黃雅琪。〈以鄰二氮菲法測定地下水鐵之改良〉。《環境分析化學》，42(3), 2021, 217–228。
+ World Health Organization. *Guidelines for Drinking-water Quality*, 4th ed. Geneva: WHO, 2022. #link("https://www.who.int/publications/i/item/9789240045064")[who.int]

#pagebreak()

#heading(numbering: none)[附錄 A　資料處理程式]

以 Python 重算迴歸結果，並將稀釋倍率計入樣品濃度。

```python
import numpy as np

# 濃度 (mg/L) 與三次測量之平均吸光度
conc = np.array([0.0, 1.0, 2.0, 4.0, 6.0, 8.0])
absb = np.array([0.002, 0.203, 0.405, 0.809, 1.210, 1.611])

slope, intercept = np.polyfit(conc, absb, 1)
pred = slope * conc + intercept
r2 = 1 - ((absb - pred) ** 2).sum() / ((absb - absb.mean()) ** 2).sum()
print(f"A = {slope:.4f} c + {intercept:.4f}, R^2 = {r2:.4f}")

# 樣品：二倍稀釋，稀釋液吸光度 0.384
c_diluted = (0.384 - intercept) / slope
print(f"c(diluted) = {c_diluted:.2f} mg/L")
print(f"c(sample)  = {2 * c_diluted:.2f} mg/L")
```

#heading(numbering: none)[附錄 B　範本用法]

範本由三支檔案組成：`lib.typ` 定義字型、字級與版面，`example.typ` 與 `example-en.typ` 分別為中、英文範例。圖片置於 `images/` 目錄，以相對路徑引用，例如 #box[`image("images/spectrum-zh.svg")`]，圖說寫在 `caption:` 中。編譯指令為

```bash
typst compile example.typ
```

最小可用範例：

```typst
#import "lib.typ": jotting

#show: jotting.with(
  title: [報告標題],
  author: [王小明　B11234567],
  date: [2026 年 11 月 8 日],
  lang: "zh",      // 切換行距與間距
  pg-num: true,    // 頁尾頁碼，預設關閉
)
```
