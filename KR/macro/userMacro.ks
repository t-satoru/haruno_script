;===============================================================================
; userMac.ks
;								マクロ定義ファイル
;
;										2010/07/26 UCHINO KAZUYUKI
;										Copyright 2009 (C) NanoMicron/Parasol
;===============================================================================
; ■コマンドの解説
; 
;【 例 】
;	○ファイルの読み込み								：コマンドの説明
;		file		: ファイル名						：小文字表記は属性名
;		[layer]		: レイヤ番号 (def:0)				　
;		[pos]		: 位置ＩＤ (def:0)					　[属性名]は省略可能な属性です。
;		[x]			: Ｘ座標 (def:0)					　(def:)は省略した場合に使用される値です。
;		[y]			: Ｙ座標 (def:0)					
;	※座標を省略した場合、絶対座標(0, 0)が優先されます	：捕捉
;[macro name = macLoadImage]							：オリジナルタグ名
;	～～～												：
;[endmacro]												：
;
;
;	※上記のようにマクロが設定されていた場合、シナリオスクリプト上では
;	
;	[macLoadImage file=*** layer=0 x=* y=*]
;	
;	という形で指定することができます
;	※属性値の区切りは半角スペースです
;
;
;
; ※属性で指定するファイル名について
; 
; ・拡張子は省略して記述してください
;
; ・ダブルクォーテーションの記述は不要ですが、ファイル名に半角or全角スペースが
; 　あるファイルは指定する必要があります
; 	【 例 】
; 	[macPlayBgm file="one dream"]
;
; ・対応フォーマットは以下の通りです
; 　音楽データ			: ogg/wav
; 　グラフィックデータ	: bmp/jpg/png
; 　ビデオデータ		: mpg/wmv
;   wmvを使用するには Windows Media Player9 がPC環境にインストールされている必要があります


;
; ※タグ名について
; 　ユーザタグ、kagの既存タグ名は、小文字大文字などの区別に関わらず、
; 　同名指定することが出来ません。
; 　その為、こちらで任意に作成したマクロには、簡単に判別しやすいように
; 　マクロコード「mac」が先頭にあります。（基本コマンドはありませんが）
; 　ご不便をお掛けしますが、仕様なのでお許しを。





;-------------------------------------------------------------------------------
; ユーザー変数について
;-------------------------------------------------------------------------------
;
;	ユーザー変数はシナリオ進行フラグ、好感度など、シナリオ側で分岐制御などを
;	する際に必要な記憶領域のことを指します
;
;	現状では、f[0 ～ SYSTEM設定数] までの配列で確保しています、
;	後述のコマンドを使用してシナリオスクリプト上に配置してください
;
;	※SYSTEM設定数に関しては設定者に確認してください
;
;
;-------------------------------------------------------------------------------
; コメント処理について
;-------------------------------------------------------------------------------
;
;	スクリプト上でのコメント処理は 行の先頭に ;(半角セミコロン) を配置してください
;
;	C、C++言語の /* ～ */ や // ではありませんので、気をつけてください
;
;




;-------------------------------------------------------------------------------
; 制御系コマンド
;-------------------------------------------------------------------------------

;	○ [if] ( 条件によりシナリオを実行 )
;		exp		:評価条件式
;				条件式には < > <= >= == != && || の演算子が使用可能です
;
;	式を評価し、その結果が true ( または 0 以外 ) ならば、
;	elsif・else・endif のいずれかまでにある文章やタグを実行し、
;	そうでない場合は無視します。
;	if ～ endif の間にはラベルを挟まないでください。

;	例1 [if exp="false"]
;		ここは表示されない
;	[else]
;		ここは表示される
;	[endif]
;
;	例2 [if exp="false"]
;		ここは表示されない
;	[elsif exp="false"]
;		ここは表示されない
;	[else]
;		ここは表示される
;	[endif]

;	例3
;	[eval exp="f[0] = 10"]
;	
;	[if exp="10 < f[0]"]
;		ここは表示されない
;	[elsif exp="0 == f[0]"]
;		ここは表示されない
;	[else]
;		ここは表示される
;	[endif]


;-------------------------------------------------------------------------------

;	○ [else] ( if の中身が実行されなかったときに実行 )

;	if タグもしくは elsif タグ と endif タグの間で用いられます。
;	if または elsif ブロックの中身がひとつも実行されていないとき、
;	else から endif までの間を実行します。

;-------------------------------------------------------------------------------

;	○ [elsif] ( それまでの if の中身が実行されていなかったときに、条件付きで実行 )
;		exp		:評価条件式
;				条件式には < > <= >= == != && || の演算子が使用可能です

;	if タグと endif タグの間で用いられます。
;	それまでの if タグまたは elsif タグの中身がひとつも実行されていないときに
;	式を評価し、その結果が真ならば elsif から次の elsif・else・endif までの間を実行します
;	※elseif ではないので注意してください
;
;-------------------------------------------------------------------------------

;	○ [endif] ( 条件によりシナリオを実行(の終了) )

;	if タグの終了を示します
;	
;
;-------------------------------------------------------------------------------

;	○ [eval] ( 式の評価 )

;		exp		:評価する式を指定します。 
;				式には = + - / * += -= の演算子が使用可能です
;
;	exp で示された式を評価します。
;	通常は変数への値の代入に用います。

;	例:
;	[eval exp="f[0] = 500"]
;	↑変数 f[0] に数値を代入している
;
;	[eval exp="f[0] += 100"]
;	↑変数 f[0] に100を加算している(f[0]の中は600)

;-------------------------------------------------------------------------------

;	○SYSTEM SAVE
;	※現状のSYSTEM SAVEフラグをファイルに書き出します

[macro name = macSystemSave]
	[SystemSave]
[endmacro]

;-------------------------------------------------------------------------------

;	○ファイルチェンジ
;	file		: チェンジするファイル名
;	※処理しているスクリプトシナリオファイルを変更します

[macro name = macChange]
	[change file=%file]
[endmacro]

;-------------------------------------------------------------------------------

;	○リプレイ開始コマンド
;		引数なし
;	※リプレイシーンの初期化処理を行います

[macro name = macReplayStart]
	;//リプレイモード以外は素通りします
	[if exp="MainObj.ReplayFlag == 1"]
		;//※以下の処理はタイトル毎に調整して構いません
		[macWindowView type=0]
		[macTransSet]
		[macBackColor color=0xffffff]
		[macFade time=1000]
		; //＊ウェイト
		[macWait time=1000]
	[endif]
[endmacro]

;-------------------------------------------------------------------------------

;	○リプレイ終了コマンド
;		引数なし
;	※リプレイシーンを終了して、リプレイ選択画面に戻ります

[macro name = macReturnReplay]
	;//リプレイモード以外は素通りします
	[if exp="MainObj.ReplayFlag == 1"]
		; //終了処理
		;//※以下の処理はタイトル毎に調整して構いません
		; //＊メッセージウィンドウ非表示
		[macWindowView type=0]
		; //☆〔　ＢＧＭ　〕停止（フェード）
		[macPlayBgm file=0 fade=2000]
		; //＊フェードアウト（白で時間指定）
		[macFadeOut color=0xffffff time=2000]
		; //＊ウェイト
		[macWait time=1000]
		[ReturnReplay]
	[endif]
[endmacro]

;-------------------------------------------------------------------------------

;	○エクストラ終了コマンド
;		引数なし
;	※エクストラシナリオを終了して、エクストラ選択画面に戻ります

[macro name = macReturnExtra]
	[ReturnExtra]
[endmacro]

;-------------------------------------------------------------------------------

;	○シナリオ終了コマンド
;		引数なし
;	※通常シナリオを終了して、タイトル画面に戻ります

[macro name = macRoom]
	[macSystemSave]
	[Room]
[endmacro]

;-------------------------------------------------------------------------------

;	○ウェイト
;		time		: 完了までの時間 [ms単位]
;		[skip]		: クリックでスキップさせる (def:1)
;	※強制的にウェイトを入れます
;	※デフォルトではクリックでウェイトをスキップできます
;	※スキップさせたくない場合には、skip=0　と属性指定をしてください

[macro name = macWait]
	[hitwait time=%time skip=%skip|1]
[endmacro]

;-------------------------------------------------------------------------------

;	○スタッフロール開始
;		id	: 表示キャラID(0:奈乃花 1:このみ 2:花梨 3:雨音 4:彩菜)
;
;	※スタッフロールを流します
;	※スキップは該当IDキャラのスタッフロール通過フラグが立っている場合のみ可能です
;	※このコマンドはタイトル毎に調整が必要になります

[macro name = macStaffRollStart]
	[macWindowView type=0]
	[staffrollstart id=%id|0 ]
	[if exp="f['ENDING_SKIP'] == false"]
	[TransSet]
	[ImageFree layer=-1]
	[ImageFill layer=0 color=0xffffff]
	[macFade time=3000]
	[endif]
	[macPlayBgm]
	[macWait time=1000]
[endmacro]

;-------------------------------------------------------------------------------

;	○ランダムコマンド
;		reg			: 結果を格納するINDEX名
;		top			: 最小値
;		max			: 最大値
;	※ランダム値を発生させ、その結果を
;	※受け取るコマンドです
;	※受け取れる値は 最小値 以上、最大値以下です

[macro name = macRandomNumber]
	[randomnumber reg=%reg top=%top max=%max]
[endmacro]

;-------------------------------------------------------------------------------

;	○セーブタイトル設定コマンド
;		name		: SAVEデータにつける文字
;	※セーブデータにつけるコメント文字です
;	※SYSTEMによって使用可能か、また仕様が異なるので、
;	※必ず仕様を確認してください

[macro name = macSceneTitle]
	[scenetitle name=%name]
[endmacro]

;-------------------------------------------------------------------------------

;	○右クリック抑制
;		flag		: 右クリック抑制フラグ(0:解放 1:抑制)
;	※右クリック制御を抑制します

[macro name = macRightClickCtrl]
	[rightclickctrl flag=%flag]
[endmacro]

;-------------------------------------------------------------------------------

;	○メッセージウィンドウ消去
;		[type]		: ウィンドウ表示：非表示(1:表示 0:非表示)(def:0)

;	※メッセージウィンドウを一時的に表示させたり、非表示にさせたりします
;	　Hitretコマンドなど強制的に表示される場合もあります

[macro name = macWindowView]
	[windowview type=%type|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○ジャンプデータ格納INDEX変更
;		daystr		: LOG画面に表示する日付表示文字(全角表記)

;	※ジャンプデータの格納INDEXを変更する際に使用してください。

[macro name = macChangeJumpIndex]
	[changejumpindex daystr=%daystr]
[endmacro]

;-------------------------------------------------------------------------------

;	○日付ボード表示
;		month		: 月表示(0:xx 1 ～ 12:数字 13:Prologue 14:Epilogue)
;		day			: 日表示(0:xx 1 ～ 31:数字)
;		week		: 曜日表示(0:日曜日 ～ 6:土曜日)

;	※日付ボードを表示します。日付ボードのレイヤは [macTransSet] で表示される
;	　カーテン用レイヤには含まれない点に気をつけてください。
;	※曜日は基本的に指定された日付からSYSTEM側が割り出します。(2014年で割り出してます)
;	　スクリプト側で指定したい場合指定してください。


[macro name = macSetDayBord]
	[SetDayBord month=%month|0 day=%day|0 week=%week]
[endmacro]

;-------------------------------------------------------------------------------

;	○日付ボード消去

;	※日付ボードを消去します。
;	　日付ボードはこのコマンドで基本消去してください。


[macro name = macEraseDayBord]
	[EraseDayBord]
[endmacro]

;-------------------------------------------------------------------------------













;-------------------------------------------------------------------------------
; 選択肢系コマンド
;-------------------------------------------------------------------------------

;	○選択肢表示レジスタを消去する
;
;	※選択肢を表示する際の前準備をするコマンドです

[macro name = macSelClr]
	[selclr]
[endmacro]

;-------------------------------------------------------------------------------

;	○選択肢を設置する
;	※表示する選択肢を設置するコマンドです
;
;		text		: 表示する文字列
;		num			: 選択結果のID番号
;		flag		: 非選択判定に使用するフラグ番号
;
[macro name = macCmd]
	[cmd text=%text num=%num index=%flag]
[endmacro]

;-------------------------------------------------------------------------------

;	○選択肢を表示する
;	※設定した内容で選択肢を表示するコマンドです
;	このコマンド指定すると、選択肢を選択するまで
;	スクリプト側に制御が戻りません
;	選択した選択肢のID番号が f["selans"] というレジスタに格納されます
;
[macro name = macSelect]
	[Select]
	[SelectEnd]
[endmacro]

;-------------------------------------------------------------------------------
; ○選択肢設置サンプル
; ※f["selans"] に格納された値を if ステートを使用して判定していく形になります
;
;[macSelClr]
;	[macCmd num=1 text=選択肢１]
;	[macCmd num=2 text=選択肢２]
;	[macCmd num=3 text=選択肢３]
;	[macCmd num=4 text=選択肢４]
;[macSelect]
; --------------------------------------------------
;  RESPONSE 1-1 コマンド①
; --------------------------------------------------
;[if exp="f['selans'] == 1"]
;	[Talk name="サンプル"]
;		選択肢１を選択しました
;	[Hitret]
; --------------------------------------------------
;  RESPONSE 1-2 コマンド②
; --------------------------------------------------
;[elsif exp="f['selans'] == 2"]
;	[Talk name="サンプル"]
;		選択肢２を選択しました
;	[Hitret]
; --------------------------------------------------
;  RESPONSE 1-3 コマンド③
; --------------------------------------------------
;[elsif exp="f['selans'] == 3"]
;	[Talk name="サンプル"]
;		選択肢３を選択しました
;	[Hitret]
; --------------------------------------------------
;  RESPONSE 1-4 コマンド④
; --------------------------------------------------
;[elsif exp="f['selans'] == 4"]
;	[Talk name="サンプル"]
;		選択肢４を選択しました
;	[Hitret]
;[endif]

;-------------------------------------------------------------------------------






;-------------------------------------------------------------------------------
; テキスト系コマンド
;-------------------------------------------------------------------------------

;	○名前処理
;	※ネーム領域に表示する名前を格納します。
;		name		: 描画するキャラ名
;		id			: 表示するメッセージフレーム(0:通常 1:ヒロイン)
;		
;		※トランジションフラグを見て、描画するオート描画機能を追加しました
;
[macro name = Talk]
	;//ロード中は無視する
	[if exp="MainObj.LoadFlag == false"]
		;//■オート描画処理
		;//[setTrans]コマンドを使用したフラグが残っているか？
		[if exp="MainObj.EffectObj.SetTransFlag == true"]
			[macFade]
		[endif]
	[endif]
	
	;//フレーム変更
	[macFrameType id=%id|0]
	
	;//実際のネーム処理コマンド
	[talkwork name=%name]
	
[endmacro]

;-------------------------------------------------------------------------------

;	○メッセージ描画処理
;	※[Talk] ～ [Hitret] 間の文字列を取得して描画します
;
;	描画する位置や、可能文字数、行数など様々な設定は userFix.ks 内で
;	指定しておく必要があります
;
[macro name = Hitret]
	[hitretwork]
[endmacro]

;-------------------------------------------------------------------------------

;	○フォントサイズ変更処理
;	※描画する文字のフォントサイズを一時的に変更します
;
;	size		: 変更するフォントサイズ
;	[top]		: 変更開始箇所 (-1:全文)(def:-1)
;	[num]		: 変更する文字数 (def:0)

[macro name = macFontSize]
	[FontSize size=%size top=%top|-1 num=%num|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○フォントカラー変更処理
;	※描画する文字のフォントカラーを一時的に変更します
;
;	color		: 変更するフォントカラー
;	subcolor	: 変更するフォントカラー(袋文字色 or 影文字色) (-1:指定色)(def:-1)
;	[top]		: 変更開始箇所 (-1:全文)(def:-1)
;	[num]		: 変更する文字数 (def:0)

[macro name = macFontColor]
	[FontColor color=%color subcolor=%subcolor|-1 top=%top|-1 num=%num|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○描画速度変更処理
;	※描画する文字WAITを一時的に無くします
;
;	[spd]		: 変更する描画速度WAIT(1:max)(def:1)

[macro name = macDrawMessMaxSpd]
	[DrawMessMaxSpd spd=%spd|1]
[endmacro]

;-------------------------------------------------------------------------------











;-------------------------------------------------------------------------------
; 画像系コマンド
;-------------------------------------------------------------------------------

;	○画像描画処理
;	※指定したリソースを画面に表示します
;
;	file		: 表示するリソースファイル名
;	[layer]		: 展開するレイヤ番号(0 ～ SYSTEM指定数)(def:0)
;	[pos]		: 固定座標 (C R L LC RC LO RO) が指定可能
;	[x]			: 表示するX座標(def:0)
;	[y]			: 表示するY座標(def:0)
;	[opacity]	: 透明度 (0 ～ 255) (def:255)

;	※指定可能なレイヤ番号はSYSTEM設定に依存します
;	※表示座標はレイヤ毎に引き継ぎで消去コマンドでクリアされます
;	　固定座標と単独座標指定では固定座標が優先です
;	　立ち絵、背景、イベント画像などの種別処理がありますので、
;	　それについてはSYSTEM設定者に確認してください

[macro name = macImageDraw]
	[ImageDraw file=%file layer=%layer|0 pos=%pos x=%x|0 y=%y|0 opacity=%opacity ]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像消去処理
;	※指定したレイヤ番号の画像と情報を削除します
;
;	[layer]		: 削除するレイヤ番号(-1 ～ SYSTEM指定数)(-1:全レイヤ)(def:0)

;	※指定可能なレイヤ番号はSYSTEM設定に依存します

[macro name = macImageFree]
	[ImageFree layer=%layer|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像塗りつぶし処理
;	※指定したレイヤ番号のレイヤを指定色で塗りつぶします
;
;	[layer]		: 処理するレイヤ番号(0 ～ SYSTEM指定数)(def:0)
;	[color]		: 指定色(16進数で指定)(def:0)
;	※指定可能なレイヤ番号はSYSTEM設定に依存します

[macro name = macImageFill]
	[ImageFill layer=%layer|0 color=%color|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像移動＆透過度変更
;		[layer]		: レイヤ番号 (def:0 max:20)
;		[x]			: 移動距離Ｘ (現在位置からの相対指定 or 絶対座標) (def:0)
;		[y]			: 移動距離Ｙ (現在位置からの相対指定 or 絶対座標) (def:0)
;		[time]		: 移動時間 [ms単位] (def:1000)
;		[opacity]	: 透過度 (透明0～不透明255の絶対指定)
;					: 省略した場合は現在の透過度のままです
;		[delay]		: 移動開始までの待ち時間 [ms単位] (def:0)
;		[accel]		: 加速度移動するかどうか (def:0)
;					　0 を指定すると、最初から最後まで一定の割合で移動処理が進行します
;					　-1 未満の数を指定すると、最初は早く、徐々に遅くなります
;					　1 より大きい数を指定すると、最初は遅く、徐々に早くなります
;					　大きい値を入れないと 0 との差が判らないので、-2、-3 や 2、3 などを推奨します
;		[type]		: 座標指定MODE (w:絶対座標 o:相対座標) (def:o)
;
;	　透過度を指定することにより段々消えながら（その逆も）移動させることができます
;	　位置を変えずに透過度だけを変えたい場合は、x と y には 0 を入れてください
;	※このコマンドは、終了を待たずにメッセージを表示しますが、
;	　表情替えなどのCG変更、ズームコマンドなどとの併用は誤動作の元です
;	　必ず終了後に他のコマンドを実行してください
;	※このコマンドは、[macWaitMove]又は[macStopMove]とセットで使用してください
;	　終了を待ちたい場合は、[macWaitMove]を任意の場所に入れてください
;	　移動途中で強制終了したい場合は、[macStopMove]を任意の場所に入れてください
;
[macro name = macImageMove]
	[imagemove layer=%layer|0 x=%x|0 y=%y|0 opacity=%opacity time=%time|1000 delay=%delay|0 accel=%accel|0 type=%type|o]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像移動スプライン移動＆透過度変更
;		path		: 移動距離座標 (絶対座標)
;		[layer]		: レイヤ番号  (def:0 max:20)
;		[time]		: 支点から支点までの移動時間 [ms単位] (def:300)
;					　TOTALTIMEは支点×timeとなります
;		[delay]		: 移動開始までの待ち時間 [ms単位] (def:0)
;		[accel]		: 加速度移動するかどうか (def:0)
;					　0 を指定すると、最初から最後まで一定の割合で移動処理が進行します
;					　-1 未満の数を指定すると、最初は早く、徐々に遅くなります
;					　1 より大きい数を指定すると、最初は遅く、徐々に早くなります
;					　大きい値を入れないと 0 との差が判らないので、-2、-3 や 2、3 などを推奨します
;
;	　透過度を指定することにより段々消えながら（その逆も）移動させることができます
;	※このコマンドは、終了を待たずにメッセージを表示しますが、
;	　表情替えなどのCG変更、ズームコマンドなどとの併用は誤動作の元です
;	　必ず終了後に他のコマンドを実行してください
;	※このコマンドは、[macWaitMove]又は[macStopMove]とセットで使用してください
;	　終了を待ちたい場合は、[macWaitMove]を任意の場所に入れてください
;	　移動途中で強制終了したい場合は、[macStopMove]を任意の場所に入れてください
;
;	※座標指定
;	移動位置を指定します。
;	移動位置は、x(レイヤ左端位置), y(レイヤ上端位置), opacity(レイヤ濃度) を３つづつ、カンマや空白、( ) で区切って指定します。
;	これらの間を、スプライン補間または直線補間にてレイヤが移動します。
;	opacity にはレイヤの表示濃度を指定します。レイヤの濃度も点から点を移動する間に連続的に変化します。
;
;	例：[macImageSpMove layer=1 time=500 path="(320,240,0) (320,240,511) (320,240,0) (320, 240,0)"]
;
[macro name = macImageSpMove]
	[imagespmove layer=%layer|0 path=%path time=%time|300 delay=%delay|0 accel=%accel|0 functype=1]
[endmacro]

;-------------------------------------------------------------------------------

;	○移動＆透過度演出を待つ
;		[skip]		: クリックでスキップさせる (def:1)
;	※[macImageMove]又は[macImageShake]系コマンドで動作中の演出の終了を待ちます

[macro name = macWaitMove]
	[WaitMove skip=%skip|1]
[endmacro]

;-------------------------------------------------------------------------------

;	○移動＆透過度演出を強制終了する
;	※[macImageMove]コマンドで動作中の演出を強制終了させます

[macro name = macStopMove]
	[StopMove]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像レイヤのZOOM処理
;
;		[layer]		: レイヤ番号 (def:0)
;		dl			: 最終矩形の左端位置
;		dt			: 最終矩形の上端位置
;		[rate]		: 拡縮率(%指定) (def:100)
;		[time]		: ズーム時間 [ms単位] (def:0)
;		[accel]		: 加速度移動するかどうか (def:0)
;					　0 を指定すると、最初から最後まで一定の割合で移動処理が進行します
;					　-1 未満の数を指定すると、最初は早く、徐々に遅くなります
;					　1 より大きい数を指定すると、最初は遅く、徐々に早くなります
;					　大きい値を入れないと 0 との差が判らないので、-2、-3 や 2、3 などを推奨します
;					※コマンドの仕様上アニメーションと同時に実行することはできません。
;		[type]		: 拡大縮小のタイプを指定します (def:1)
;					※タイプ説明：
;					0 : 最近傍点法が用いられます
;					1 : 低精度の線形補間が用いられます
;					2 : 線形補間が用いられます
;					速度は 0 > 1 > 2 の順に高速ですが、画質は速度が
;					速ければ速いタイプほど低画質になります。
;		[image]		: 画像リソースを再度読み込んで使用するか
;					 (0:再読込 1:レイヤの画像をそのまま使用)(def:0)

[macro name = macImageZoom]
	[imagezoom layer=%layer|0 dl=%dl dt=%dt rate=%rate|100 time=%time|0 accel=%accel|0 type=%type|1 image=%image|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○グラフィックのガンマ補正処理
;		[layer]		: レイヤ番号 (def:0)
;		[gray]		: グレースケールにするか？ (def:0)
;		[r]			: 赤のガンマ補正値 (0.1 ～ 1.0(def) ～ 9.9)
;		[g]			: 緑のガンマ補正値 (0.1 ～ 1.0(def) ～ 9.9)
;		[b]			: 青のガンマ補正値 (0.1 ～ 1.0(def) ～ 9.9)
;		
;		ZOOM後の画像などにガンマ処理を使用する場合に使用します。
;		ZOOM処理完了後に指定してください。ZOOM処理中に使用することはできません
;		
;		※たとえば画像をセピア調にするには、gray=1 r=1.4 g=1.2 b=0.8 と指定します
;		体験版ではガンマ補正でごまかすかも　夜　r=0.6 g=0.8 b=0.8　夕方　r=1.1 g=0.8 b=0.8

[macro name = macGammaImage]
	[imagegamma layer=%layer|0 gray=%gray|0 rgamma=%r|1.0 ggamma=%g|1.0 bgamma=%b|1.0]
[endmacro]

;-------------------------------------------------------------------------------

;	○ガンマ補正しながらグラフィックファイルの表示
;		file		: ファイル名
;		[layer]		: レイヤ番号 (def:0)
;		[pos]		: 位置ＩＤ [left_out(lo)/left(l)/left_center(lc)/center(c)/right_center(rc)/right(r)/right_out(ro)] (def:0)
;		[x]			: Ｘ座標 (def:0)
;		[y]			: Ｙ座標 (def:0)
;		[opacity]	: 透過度 (def:255)
;		[gray]		: グレースケールにするか？ (def:0)
;		[r]			: 赤のガンマ補正値 (0.1 ～ 1.0(def) ～ 9.9)
;		[g]			: 緑のガンマ補正値 (0.1 ～ 1.0(def) ～ 9.9)
;		[b]			: 青のガンマ補正値 (0.1 ～ 1.0(def) ～ 9.9)
;	※座標系属性を全て省略した場合、絶対座標(0, 0)になります
;	※すでに表示済みの場合は座標は変更されません（表情変え等）
;	※たとえば画像をセピア調にするには、gray=1 r=1.4 g=1.2 b=0.8 と指定します
;	※例　夜　r=0.6 g=0.8 b=0.8　夕方　r=1.1 g=0.8 b=0.8

[macro name = macGammaImageDraw]
	[imagedraw file=%file layer=%layer|0 pos=%pos x=%x y=%y opacity=%opacity|255]
	[imagegamma layer=%layer|0 gray=%gray|0 rgamma=%r|1.0 ggamma=%g|1.0 bgamma=%b|1.0]
[endmacro]

;-------------------------------------------------------------------------------

;	○グラフィックの明度・コントラスト処理
;		[layer]		: レイヤ番号 (def:0)
;		[light]		: 明度調整値 (def:0)
;		[contrast]	: コントラスト値 (def:0)
;		
;		ZOOM後の画像などに明度・コントラスト処理を使用する場合に使用します。
;		ZOOM処理完了後に指定してください。ZOOM処理中に使用することはできません
;		
;		* 明度とコントラスト
;			明度 -255 ～ 255, 負数の場合は暗くなる
;			コントラスト -100 ～100, 0 の場合変化しない

[macro name = macLightImage]
	[imagelight layer=%layer|0 light=%light|0 contrast=%contrast|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○立ち絵時間指定コマンド
;		[timeid]	: 表示する立ち絵の時間帯指定(def:0)
;					[0:通常 1:夕方 2:夜１ 3:夜２ 4:夜３]
;		
;		※表示する立ち絵素材の時間帯を設定します。
;		　このコマンドは継続タイプです
;		　シナリオの先頭で使用するとそこ以降から立ち絵の画像に
;		　固定ガンマ処理が施されます
;		※固定ガンマ処理の設定値は別ファイルで設定されていますので、
;		　SYSTEM設定者に確認してください

[macro name = macSetBustUpTime]
	;代入処理
	[Substitution index="BuTimeSelect" val=%timeid|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○立ち絵描画遅延処理コマンド
;		file	: メインレイヤ表示する画像ファイル
;		file2	: テンポラリに表示する画像ファイル
;		[layer]	: レイヤ番号(def:0)
;		[x]		: x座標設定(def:0)
;		[y]		: y座標設定(def:0)
;		[pos]	: 基準座標設定
;		[time]	: テンポラリレイヤとメインレイヤの切り替え開始時間(def:1000)
;		[fade]	: 転送方法(1:Fade 0:単純転送)(def:1)
;		[drawtype]	: 切り替え方法 (1:両レイヤを変更 0:テンポラリのみ変更)(def:0)
;		
;		※座標はposが優先です。
;		
;		※画像を表示した後、設定時間後にテンポラリ画像と切り替え処理が始まります。
;		　設定時間で表示が切り替わるわけではないのに注意してください
;		
;		drawtype：素体を変更したい場合は、「両レイヤを変更する」を選択してください。
;				　表情替えの場合は「テンポラリのみ変更」を変更した方が良い感じがしました
;		
;		

[macro name = macImageDelayDraw]
	;//遅延描画
	[imagedraw file=%file file2=%file2 layer=%layer|0 pos=%pos x=%x y=%y time=%time|1000 fade=%fade|1 drawtype=%drawtype|0 zoom=%zoom|1 def=0]
	[macFaceDelayDraw file1=%file file2=%file2 time=%time|1000 fade=%fade|1 delaytype=%drawtype|0 ]
[endmacro]

;-------------------------------------------------------------------------------







;-------------------------------------------------------------------------------
; フェイス系コマンド
;
; ※以下フェイス系コマンドは userFix.ks の nFACE_FLAG指定子 が true 設定の場合のみ
;　使用可能です
;
; ※フェイス画像について
;
; フェイス画像は基本的に使用されている立ち絵素材から指定矩形をコピーして
; 使用しています(矩形の指定は別ファイルです)
;
;-------------------------------------------------------------------------------

;	○フェイス描画コマンド
;		[file]	: 画像ファイル名
;		[type]	: コマンド持続TYPE(0:1hitret 1:再指定まで)(def:0)
;		[force]	: 強制描画フラグ(0:通常 1:強制)(def:0) 非表示設定名でも表示する場合に指定してください
;		
;		[gray]		: グレイフラグ
;		[rg]		: 赤ガンマ値
;		[gg]		: 緑ガンマ値
;		[bg]		: 青ガンマ値
;		[light]		: 明度値
;		[contrast]	: コントラスト値
;		[opacity]	: 透明度
;		
;	※指定された画像をキャラ名、表示されている立ち絵、表情に関わらず表示します
;	　type 1 を解除する場合はファイル名を指定せずにコマンドを使用してください。
;	
[macro name = macFaceDraw]
	[facehidden type=2]
	[facedraw file=%file type=%type|0 force=%force|0 gray=%gray rg=%rg gg=%gg bg=%bg light=%light contrast=%contrast opacity=%opacity]
[endmacro]

;-------------------------------------------------------------------------------

;	○フェイス抑制コマンド
;		[type]	: コマンド持続TYPE(0:1hitret 1:再指定まで 2:解除)(def:0)
;
;	※フェイス描画を抑制します
;	　[macFaceDraw] コマンドと相対するコマンドです。
;	　[macFaceDraw] と [macFaceHidden] では最後に呼ばれたコマンドが優先されます
;	　また、それぞれのコマンド内部で相対するコマンド情報はクリアされますので、
;	　注意してください
;
;例：
;
;	[macFaceDraw file=*** type=1] ※継続描画
;
;	[Talk name=＊＊]
;	テスト
;	[Hitret]
;
;	[macFaceHidden] ※描画抑制(1hitret) ここで継続描画はクリアされます
;
;	[Talk name=＊＊]
;	テスト２
;	[Hitret]
;	
;	[Talk name=＊＊] ※通常フェイス処理になります
;	テスト３
;	[Hitret]
;

[macro name = macFaceHidden]
	[facedraw]
	[facehidden type=%type|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○フェイス遅延描画コマンド
;		[file1]		: 画像ファイル名
;		[file2]		: 画像ファイル名
;		[time]		: テンポラリレイヤとメインレイヤの切り替え開始時間(def:1000)
;		[fade]		: 転送方法(1:Fade 0:単純転送)(def:1)
;		[delaytype]	: 切り替え方法 (0:テンポラリのみ変更 1:両レイヤを変更)(def:0)
;		[force]	: 強制描画フラグ(0:通常 1:強制)(def:0) 非表示設定名でも表示する場合に指定してください
;		
;	※指定された画像をキャラ名、表示されている立ち絵、表情に関わらず
;	　遅延表示します

[macro name = macFaceDelayDraw]
	[facehidden type=2]
	[facedraw file=%file1 file2=%file2 time=%time|1000 fade=%fade|1 delaytype=%delaytype|0 force=%force|0]
[endmacro]

;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------
; メッセージフレーム変更 コマンド
;-------------------------------------------------------------------------------
;
; ○フレーム変更コマンド
;	[id]		: 0（通常）1（ヒロイン視点）（def:0）
;
;	※表示するメッセージフレーム素材を設定します。
;	　このコマンドは継続タイプです
;
[macro name = macFrameType]
	;代入処理
	[Substitution index="MessFrameType" val=%id|0]
	[FrameType]
[endmacro]

;-------------------------------------------------------------------------------









;-------------------------------------------------------------------------------
; サウンド系コマンド
;-------------------------------------------------------------------------------

;	○ＢＧＭの制御
;		file		: ファイル名／ 0 で停止(def:0)
;		[fade]		: フェード時間 [ms単位] (def:0)
;		[pan]		: LR設定(def:0) -100 ～ 0 ～ 100 で設定してください
;
[macro name = macPlayBgm]
	[playbgm file=%file|0 fade=%fade|0 pan=%pan|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○効果音の制御
;		file		: ファイル名／０で停止
;		[id]		: レイヤ番号(使用可能な番号はSYSTEM設定に依存) [def:0]
;		[loop]		: loop再生 (def:0)
;		[pan]		: LR設定(def:0) -100 ～ 0 ～ 100 で設定してください
;		[delay]		: DELAY TIME(def:0)
;		[fade]		: フェード時間 [ms単位] (def:0)
;
[macro name = macPlaySe]
	[playse file=%file|0 id=%id|0 loop=%loop|0 pan=%pan|0 delaytime=%delay|0 fade=%fade|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○効果音待機
;	※効果音が終了するまで待機します
;	単独再生効果音などの待機をしたい場合などに使用してください
;
;		[id]		: ID番号 [def:0]
;
[macro name = macSeWait]
	[SeWait id=%id|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○音声の再生
;		file		: ファイル名
;		[id]		: レイヤ番号(使用可能な番号はSYSTEM設定に依存) (def:0)
;		[pan]		: LR設定(def:0) -100 ～ 0 ～ 100 で設定してください
;		[play]		: 再生制御 1:即再生 0:メッセージ描画時再生 (def:0)
;
[macro name = macPlayVoice]
	[voice file=%file id=%id|0 pan=%pan|0 play=%play|0]
[endmacro]

;-------------------------------------------------------------------------------

;	○音声停止
;	※強制的に音声を停止します
;	単独再生音声などを停止したい場合などに使用してください
;
;		[id]		: レイヤ番号(使用可能な番号はSYSTEM設定に依存) [def:-1(全停止)]
;
[macro name = macStopVoice]
	[voicestop id=%id|-1]
[endmacro]

;-------------------------------------------------------------------------------

;	○音声待機
;	※音声が終了するまで待機します
;	単独再生音声などの待機をしたい場合などに使用してください
;
;		[id]		: ID番号 [def:0]
;
[macro name = macVoiceWait]
	[voicewait id=%id|0]
[endmacro]

;-------------------------------------------------------------------------------






;-------------------------------------------------------------------------------
;
; ムービー再生
;
;-------------------------------------------------------------------------------

;	○ムービーを再生する
;		指定ムービーファイルを再生します
;		再生が終了した後もムービーの画像は残っていますので、
;		後述の CloaseMovie コマンドを使用して画面を消去してください
;		file		: ファイル名
;		[layer]		: 描画するレイヤ番号 (def:-1 専用レイヤを使用し最前面へ描画)
;		[loop]		: ループフラグ (def:0)
;		[mode]		: PLAY MODE (def:0) 0:Overlay Mode
;										1:Layer   Mode
;										2:Mixer   Mode
;
;		[cursor]	: カーソル表示・非表示 (表示:1 非表示:0)(def:1)
;		[cancel]	: キャンセルフラグ (許可:0 ※1以上は条件付き許可 -1:不許可)(def:0)
;					※waitを[止めない]にした場合はスクリプト側から停止させる必要があります
;					
;		[wait]		: 再生終了時までスクリプトの制御を止めるか (0:止めない 1:止める)(def:1)
;					※[止める]にして[loop]フラグがONの場合終了イベントが発生しないので指定出来ません
;
;	※MODEの説明
;
;	Overlay Mode
;	
;	OverlayはDirectDrawを使用してMOVIEを再生するモードです。
;	強制的に最前面の位置で再生されます。
;	従って終了確認などの表示ができません
;	再生処理は一番軽いモードです。
;
;
;	Layer Mode
;	
;	LayerModeは画像描画するレイヤにMOVIEを表示するモードです。
;	画像レイヤなので、レイヤの位置を指定することができます。
;	再生処理はOverlayに比べると若干重いです。
;
;
;	Mixer Mode
;
;	MixerModeはレイヤに描画しつつ、画像のアルファ値を設定できる
;	モードです。３つのモードでは再生処理が一番重いです。
;
;
;
;	※対応形式
;
;	再生可能な形式はmpg、wmvです。
;
;	ただし、wmvはOverlay Modeだとフルスクリーン時に問題がでるので、
;	wmvを使用する場合はLayerModeを指定する必要があります。
;
;
;	LayerModeを使用する際は、画像の拡縮補完がされないため画面サイズの
;	MOVIEが必要になります。(mpgでも同様)
;
;	Layer Modeでないと再生中にマウスカーソルの消去ができません。
;
[macro name = macPlayMovie]
	[playmovie file=%file layer=%layer|-1 loop=%loop|0 mode=%mode|0 cursor=%cursor|1 cancel=%cancel|0 wait=%wait|1]
[endmacro]

;-------------------------------------------------------------------------------

;	○ムービー画像を消去する
;		再生終了したムービー画面を消去します
;		トランジションをかけてムービーを消去したい場合などに使用します
;		※このコマンドは停止でなく、再生終了時に使用するものです
[macro name = macCloseMovie]
	[CloseMovie]
[endmacro]

;-------------------------------------------------------------------------------

;	○ムービーを停止する
;		再生中のムービーを停止します
;		ループ再生したムービーはこのコマンドを使用してムービーを停止させる
;		必要があります
;		※このコマンドの後には macCloseMovie を使用して画面を消去してください
[macro name = macStopMovie]
	[StopMovie]
[endmacro]

;-------------------------------------------------------------------------------







;-------------------------------------------------------------------------------
; 画面演出コマンド
;-------------------------------------------------------------------------------

;	○背景レイヤ塗りつぶし
;	[color]		: 色値(16進数で指定) (def:coBLACK)
;
;	※全レイヤを一度破棄して、0番レイヤを指定色で塗りつぶす
;	コマンドです

[macro name = macBackColor]
	[ImageFree layer=-1]
	[ImageFill layer=0 color=%color|coBLACK]
[endmacro]

;-------------------------------------------------------------------------------
;
;	○トランジション準備コマンド
;
;	※トランジション系処理を行うための準備コマンドです
;	※このコマンド使用後でないと、トランジション、フェードなどのコマンドが
;	動作しませんので、使用するのを忘れないでください

[macro name = macTransSet]
	[TransSet]
[endmacro]


;	■トランジション、フェード系コマンドの説明
;	
;	トランジション、フェード系などのコマンドですが、挙動は同じ処理を
;	しています
;	
;	この [macTransSet] コマンドは、現在表示されている画面をキャプチャーして最前面へ表示する
;	という処理を行っています(メッセージフレームよりも手前です)
;	
;	そして、トランジション、フェード系コマンドは表示されているキャプチャー画像を消去する
;	という処理を行っています
;	
;	キャプチャー画像はカーテンをイメージしてもらえると判り易いと思います
;	カーテンで隠しておいて、カーテン内部で変更しておき、完了したらカーテンを開けるという流れです
;	以下、実際のコマンド記述例です
;
;例：
;
;	//★〔　背景　〕七森家・マンション外観・夜１
;	[macImageDraw file=BG_07C_01]
;
;	[Talk name=テスト]
;	背景ＢＧ＿０７Ｃ＿０１が表示されています
;	[Hitret]
;
;	//＊現在表示されている画面をキャプチャーして最前面に表示
;	[macTransSet]
;
;	※ここからフェードコマンドまで、キャプチャー画像に隠れているので
;	実際には画面に表示されていません
;	キャプチャー画像で隠している間に画像変更を行います
;
;	//★〔　背景　〕七森家・リビングキッチン・夜１
;	[macImageDraw file=BG_04C_01]
;	//★〔　立ち絵　〕みるく・私服(Ａ正面)・喜び／笑いＣ
;	[macImageDraw file=CH_A200L_01B layer=1  pos=c ]
;
;	//＊フェード表示 ←キャプチャー画像をフェードで削除する
;	// 画面では更新した画像がフェード表示されたように見える
;	[macFade time=1000]
;
;	[Talk name=テスト]
;	背景と立ち絵が更新されてフェードで表示されました
;	[Hitret]

;-------------------------------------------------------------------------------

;	○フェード更新
;		[time]		: 完了までの時間 [ms単位] (def:300ms)

;	※[macTransSet] で表示されたキャプチャー画像をフェードで消去します
;	　[macTransSet] を使用している状態で使用してください

[macro name = macFade]
	[fadework time=%time|300]
[endmacro]

;-------------------------------------------------------------------------------

;	○フェードアウト
;		[time]		: 完了までの時間 [ms単位] (def:1000ms)
;		[color]		: 色値(16進数で指定) (def:coBLACK)
;		[mes]		: メッセージウィンドウを残すか？ (def:0 残さない)・1で残す

;	※内部で [macTransSet] を行っているので、このコマンド前には [macTransSet] は指定する
;	　必要はありません
;	※0番レイヤ以外をフェードしながら消去し、0番レイヤを指定色で塗りつぶして表示します
;	※このコマンドは、フェード終了を待ってからメッセージを表示します
;	※定義されている色一覧 (他の色はフォトショップなどで調べて指定してください)

;	var	coBLACK	= 0x000000
;	var coWHITE	= 0xffffff
;	var coRED	= 0xff0000
;	var coGREEN	= 0x00ff00
;	var coBLUE	= 0x0000ff
;	var coAQUA	= 0x00ffff
;	var coPURPLE= 0xff00ff
;	var coYELLOW= 0xffff00

[macro name = macFadeOut]
	;現在の画面をキャプチャーする
	[macTransSet]
	
	;メッセージウィンドウ設定が0(残さない)の場合
	[macWindowView type=%mes|0]
	
	[macImageFree layer=-1]
	[macImageFill color=%color|coBLACK]
	
	[macFade time=%time|1000]
	
[endmacro]

;-------------------------------------------------------------------------------

;	○トランジション更新
;		file		: ルールファイル(拡張子無しで指定)
;		[time]		: 完了までの時間 [ms単位] (def:300ms)

;	※[macTransSet] で表示されたキャプチャー画像をルール画像を使用して消去します
;	　[macTransSet] を使用している状態で使用してください

[macro name = macTrans]
	[transwork file=%file time=%time|300]
[endmacro]

;-------------------------------------------------------------------------------

;	○トランジション消し
;		file		: ルールファイル(拡張子無しで指定)
;		[time]		: 完了までの時間 [ms単位] (def:1000ms)
;		[color]		: 色 (def:coBLACK)
;		[mes]		: メッセージウィンドウを残すか？ (def:0 残さない)・1で残す

;	※全てのレイヤをトランジションで消去します(0番レイヤは作成されます)
;	※このコマンドは、終了を待ってからメッセージを表示します
;	※内部で [macTransSet] を行っているので、このコマンド前には [macTransSet] は指定する
;	　必要はありません
;	※定義されている色一覧 (他の色はフォトショップなどで調べて指定してください)
;	　組み込み側で定義しないと使用できないので連絡お願いします
;	　coBLACK	= 0x000000
;	　coWHITE	= 0xffffff
;	　coRED		= 0xff0000
;	　coGREEN	= 0x00ff00
;	　coBLUE	= 0x0000ff
;	　coAQUA	= 0x00ffff
;	　coPURPLE	= 0xff00ff
;	　coYELLOW	= 0xffff00

[macro name = macTransOut]
	
	;現在の画面をキャプチャーする
	[macTransSet]
	
	;メッセージウィンドウ設定が0(残さない)の場合
	[macWindowView type=%mes|0]
	
	;画像 全消し
	[macImageFree layer=-1]
	
	;色指定した場合
	[macImageFill color=%color|coBLACK]
	
	;時間指定した場合
	[macTrans file=%file time=%time|1000]
	
[endmacro]

;-------------------------------------------------------------------------------

;	○クェイク
;		[time]		: 完了までの時間 [ms単位] (def:500ms)
;		[x]			: Ｘ揺れ幅 (def:0)
;		[y]			: Ｙ揺れ幅 (def:0)
;		[mode]		: モード (def:0) 0:通常
;									 1:画面外単色塗りつぶし
;		[color]		: 色値(16進数で指定) (def:coBLACK)

;	※画面全体を揺らします
;	※このコマンドは、クェイク終了を待ってからメッセージを表示します
;	※[画面外単色塗りつぶし]は背景が画面一杯のサイズしかない場合、
;	　ずれた際に見える画面の色を指定します

[macro name = macQuake]
	[quake time=%time|500 hmax=%x|0 vmax=%y|0 mode=%mode|0 color=%color|coBLACK]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像レイヤ単位の揺らし
;		[layer]		: レイヤ番号 (def:0 指定可能番号はSYSTEM設定者に確認)
;		x			: 揺れ幅Ｘ ( - 指定で左、+ 指定( + は省略可)で右)
;		y			: 揺れ幅Ｙ ( - 指定で上、+ 指定( + は省略可)で下)
;		[type]		: s:単方向 w:双方向 (def:s)
;		[cnt]		: 揺らし回数 (def:1)
;		[time]		: 移動時間 [ms単位] (def:220)
;		[delay]		: 移動開始までの待ち時間 [ms単位] (def:0)
;	※このコマンドは、揺らし終了を待ってからメッセージを表示します
;	※このコマンドの後には、[macWaitMove]コマンドを入れてください
;	※複数レイヤを同時に揺らす場合は[macWaitMove]コマンドの入れ方に注意してください

[macro name = macImageShake]
	[SpPath x=%x y=%y cnt=%cnt|1 layer=%layer|0 type=%type|s]
	[imagespmove layer=%layer|0 path="&f.path" time=%time|220 delay=%delay|0 functype=0]
[endmacro]

;-------------------------------------------------------------------------------

;	○画像透過度設定
;		[layer]		: レイヤ番号 (def:0 指定可能番号はSYSTEM設定者に確認)
;		opacity		: 透過度 (透明0～不透明255の絶対指定)
;		[time]		: 指定透過度にかかるまでの時間(def:0)
;	※画像レイヤの透過度を設定します。
;	[macWaitMove]とセットで使用してください。

[macro name = macImageOpacity]
;	透過度の現在値を代入
	[imagemove layer=%layer|0 x=0 y=0 opacity=%opacity time=%time|0 delay=0 accel=0]
[endmacro]

;-------------------------------------------------------------------------------

;	○フラッシュ
;		[color]		: 色値(16進数で指定) (def:coWHITE)
;		[nun]		: 回数 (def:1)
;		[time]		: 点滅時間 [ms単位] (def:300ms)


;	※画面全体をフラッシュさせます
;	※このコマンドは、フラッシュ終了を待ってからメッセージを表示します

[macro name = macFlash]
	[flash color=%color|coWHITE num=%num|1 time=%time|300]
[endmacro]

;-------------------------------------------------------------------------------








[return]

