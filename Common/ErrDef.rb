# CtrlCmdDef.rb
#  EDCB Protocol implementation in Ruby
# ref Common/ErrDef.h

require_relative 'TrueFalse'

module EDCB
	module Constants
		ERR_FALSE				= FALSE		# 汎用エラー
		NO_ERR					= TRUE		# 成功
		ERR_INIT				= 10		# 初期化失敗
		ERR_NOT_INIT			= 11		# 未初期化
		ERR_SIZE				= 12		# 入力サイズが不正
		ERR_LOAD_MODULE			= 13		# モジュールのロードに失敗
		ERR_INVALID_ARG			= 14		# 引数が無効
		ERR_NOT_FIND			= 15		# 情報が見つからなかった
		ERR_NEED_NEXT_PACKET	= 20		# 次のTSパケット入れないと解析できない
		ERR_CAN_NOT_ANALYZ		= 21		# 本当にTSパケット？解析不可能
		ERR_NOT_FIRST 			= 22		# 最初のTSパケット未入力
		ERR_INVALID_PACKET		= 23		# 本当にTSパケット？パケット飛んで壊れてるかも
		ERR_NO_CHAGE			= 30		# バージョンの変更ないため解析不要

		ERR_LOAD_B25			= 40		# B25Decorder.dllのロードに失敗
		ERR_OPEN_TUNER			= 41		# 指定BonDriverのOpenに失敗
		ERR_FIND_TUNER			= 42		# 指定BonDriverの検索に失敗
		ERR_LOAD_EPG			= 43		# EpgDataCap.dllのロードに失敗

		ERR_NW_ALREADY_SESSION	= 50		# セッションオープン済み
		ERR_NW_NO_SESSION		= 51		# セッション未オープン
		ERR_NW_OPEN_SESSION		= 52		# セッションオープン失敗
		ERR_NW_OPEN_CONNECT		= 53		# コネクションオープン失敗
		ERR_NW_OPEN_REQUEST		= 54		# リクエストオープン失敗
		ERR_NW_PROXY_LOGIN		= 55		# Proxy認証失敗
		ERR_NW_OPEN_FILE		= 56		# ファイルにアクセスできなかった
		ERR_NW_SEND_REQUEST		= 57		# リクエスト送信で失敗
		ERR_NW_FALSE			= 58		# ネットワーク処理でエラー
		ERR_NW_FILE_OPEN		= 59		# ファイルにアクセスできない

		NO_ERR_EPG_ALL			= 100		# EPG情報貯まった BasicとExtend両方
		NO_ERR_EPG_BASIC		= 101		# EPG情報貯まった Basicのみ
		NO_ERR_EPG_EXTENDED		= 102		# EPG情報貯まった Extendのみ

		CMD_SUCCESS				= NO_ERR	# 成功
		CMD_ERR					= ERR_FALSE	# 汎用エラー
		CMD_NEXT				= 202		# Enumコマンド用、続きあり
		CMD_NON_SUPPORT			= 203		# 未サポートのコマンド
		CMD_ERR_INVALID_ARG		= 204		# 引数エラー
		CMD_ERR_CONNECT			= 205		# サーバーにコネクトできなかった
		CMD_ERR_DISCONNECT		= 206		# サーバーから切断された
		CMD_ERR_TIMEOUT			= 207		# タイムアウト発生
		CMD_ERR_BUSY			= 208		# ビジー状態で現在処理できない（EPGデータ読み込み中、録画中など）
		CMD_NO_RES				= 250		# Post用でレスポンスの必要なし

		# チャンネルスキャン、EPG取得のステータス用
		ST_STOP					= 300		# 停止中
		ST_WORKING				= 301		# 実行中
		ST_COMPLETE				= 302		# 完了
		ST_CANCEL				= 303		# キャンセルされた
	end
	
	include Constants
end
