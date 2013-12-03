# StructDef.rb
#  EDCB Protocol implementation in Ruby
# ref Common/StructDef.h etc

require_relative 'TrueFalse'

module EDCB
	STRUCTS = [
		# ref winbase.h
		{
			name: :SYSTEMTIME,
			members:[
				[:WORD, :wYear],
				[:WORD, :wMonth],
				[:WORD, :wDayOfWeek],
				[:WORD, :wDay],
				[:WORD, :wHour],
				[:WORD, :wMinute],
				[:WORD, :wSecond],
				[:WORD, :wMilliseconds],
			]
		},
		
		# 録画フォルダ情報
		{
			name: :REC_FILE_SET_INFO,
			members: [
				[:WString, :recFolder],			# 録画フォルダ
				[:WString, :writePlugIn],		# 出力PlugIn
				[:WString, :recNamePlugIn],		# ファイル名変換PlugInの使用
				[:WString, :recFileName],		# ファイル名個別対応 録画開始処理時に内部で使用。予約情報としては必要なし
			]
		},
		
		# 録画設定情報
		{
			name: :REC_SETTING_DATA,
			members: [
				[:BYTE, :recMode],				# 録画モード
				[:BYTE, :priority],				# 優先度
				[:BYTE, :tuijyuuFlag],			# 追従モード
				[:DWORD, :serviceMode],			# 処理対象データモード
				[:BYTE, :pittariFlag],			# ぴったり？録画
				[:WString, :batFilePath],		# 録画後BATファイルパス
				[[:Vector, :REC_FILE_SET_INFO], :recFolderList],	# 録画フォルダパス
				[:BYTE, :suspendMode],			# 休止モード
				[:BYTE, :rebootFlag],			# 録画後再起動する
				[:BYTE, :useMargineFlag],		# 録画マージンを個別指定
				[:INT, :startMargine],			# 録画開始時のマージン
				[:INT, :endMargine],			# 録画終了時のマージン
				[:BYTE, :continueRecFlag],		# 後続同一サービス時、同一ファイルで録画
				[:BYTE, :partialRecFlag],		# 物理CHに部分受信サービスがある場合、同時録画するかどうか
				[:DWORD, :tunerID],				# 強制的に使用Tunerを固定
				# CMD_VER 2以降
				2,
				[[:Vector, :REC_FILE_SET_INFO], :partialRecFolder],	# 部分受信サービス録画のフォルダ
			]
		},
		
		# 登録予約情報
		{
			name: :RESERVE_DATA,
			members: [
				[:WString, :title],					# 番組名
				[:SYSTEMTIME, :startTime],			# 録画開始時間
				[:DWORD, :durationSecond],			# 録画総時間
				[:WString, :stationName],			# サービス名
				[:WORD, :originalNetworkID],		# ONID
				[:WORD, :transportStreamID],		# TSID
				[:WORD, :serviceID],				# SID
				[:WORD, :eventID],					# EventID
				[:WString, :comment],				# コメント
				[:DWORD, :reserveID],				# 予約識別ID 予約登録時は0
				[:BYTE, :recWaitFlag],				# 予約待機入った？ 内部で使用
				[:BYTE, :overlapMode],				# かぶり状態 1:かぶってチューナー足りない予約あり 2:チューナー足りなくて予約できない
				[:WString, :recFilePath],			# 録画ファイルパス 旧バージョン互換用 未使用
				[:SYSTEMTIME, :startTimeEpg],		# 予約時の開始時間
				[:REC_SETTING_DATA, :recSetting],	# 録画設定
				[:DWORD, :reserveStatus],			# 予約追加状態 内部で使用
				# CMD_VER 5以降
				5,
				[[:Vector, :WString], :recFileNameList],	# 録画予定ファイル名
				[:DWORD, :param1],					# 将来用
			]
		},
		
		{
			name: :REC_FILE_INFO,
			members: [
				[:DWORD, :id],					# ID
				[:WString, :recFilePath],		# 録画ファイルパス
				[:WString, :title],				# 番組名
				[:SYSTEMTIME, :startTime],		# 開始時間
				[:DWORD, :durationSecond],		# 録画時間
				[:WString, :serviceName],		# サービス名
				[:WORD, :originalNetworkID],	# ONID
				[:WORD, :transportStreamID],	# TSID
				[:WORD, :serviceID],			# SID
				[:WORD, :eventID],				# EventID
				[:LONGLONG, :drops],				# ドロップ数
				[:LONGLONG, :scrambles],			# スクランブル数
				[:DWORD, :recStatus],			# 録画結果のステータス
				[:SYSTEMTIME, :startTimeEpg],	# 予約時の開始時間
				[:WString, :comment],			# コメント
				[:WString, :programInfo],		# .program.txtファイルの内容
				[:WString, :errInfo],			# .errファイルの内容
				# CMD_VER 4以降
				4,
				[:BYTE, :protectFlag],

			]
			# stub: RESERVE_DATAから変換できる
		},
		
		{
			name: :TUNER_RESERVE_INFO,
			members: [
				[:DWORD, :tunerID],
				[:WString, :tunerName],
				[[:Vector, :DWORD], :reserveList],
			]
		},
		
		# チューナー毎サービス情報
		{
			name: :CH_DATA4,
			members: [
				[:INT, :space],						# チューナー空間
				[:INT, :ch],						# 物理チャンネル
				[:WORD, :originalNetworkID],		# ONID
				[:WORD, :transportStreamID],		# TSID
				[:WORD, :serviceID],				# サービスID
				[:WORD, :serviceType],				# サービスタイプ
				[:BOOL, :partialFlag],				# 部分受信サービス（ワンセグ）かどうか
				[:BOOL, :useViewFlag],				# 一覧表示に使用するかどうか
				[:WString, :serviceName],			# サービス名
				[:WString, :chName],				# チャンネル名
				[:WString, :networkName],			# ts_name or network_name
				[:BYTE, :remoconID],				# リモコンID
			]
		},
		
		# 全チューナーで認識したサービス一覧
		{
			name: :CH_DATA5,
			members: [
				[:WORD, :originalNetworkID],		# ONID
				[:WORD, :transportStreamID],		# TSID
				[:WORD, :serviceID],				# サービスID
				[:WORD, :serviceType],				# サービスタイプ
				[:BOOL, :partialFlag],				# 部分受信サービス（ワンセグ）かどうか
				[:WString, :serviceName],			# サービス名
				[:WString, :networkName],			# ts_name or network_name
				[:BOOL, :epgCapFlag],				# EPGデータ取得対象かどうか
				[:BOOL, :searchFlag],				# 検索時のデフォルト検索対象サービスかどうか
			]
		},
		
		{
			name: :REGIST_TCP_INFO,
			members: [
				[:WString, :ip],
				[:DWORD, :port],
			]
		},
=begin
		# コマンド送受信ストリーム
		{
			name: :CMD_STREAM,
			members: [
				[:DWORD, :param],		# 送信時コマンド、受信時エラーコード
				[:DWORD, :dataSize],	# dataのサイズ（BYTE単位）
				[:'BYTE*', :data],		# 送受信するバイナリデータ
			]
		},
		
		{
			name: :HTTP_STREAM,
			members: [
				[:String, :httpHeader],	# 送信時コマンド、受信時エラーコード
				[:DWORD, :dataSize],	# dataのサイズ（BYTE単位）
				[:'BYTE*', :data],		# 送受信するバイナリデータ
			]
		},
=end
		# EPG基本情報
		{
			name: :EPGDB_SHORT_EVENT_INFO,
			members: [
				[:WString, :event_name],		# イベント名
				[:WString, :text_char],			# 情報
				[:WString, :search_event_name],	# 検索使用時のイベント名
				[:WString, :search_text_char],	# 検索使用時の情報
			]
		},
		
		# EPG拡張情報
		{
			name: :EPGDB_EXTENDED_EVENT_INFO,
			members: [
				[:WString, :text_char],			# 詳細情報
				[:WString, :search_text_char],	# 検索使用時の情報
			]
		},
		
		# EPGジャンルデータ
		{
			name: :EPGDB_CONTENT_DATA,
			members: [
				[:BYTE, :content_nibble_level_1],
				[:BYTE, :content_nibble_level_2],
				[:BYTE, :user_nibble_1],
				[:BYTE, :user_nibble_2],
			]
		},
		
		# EPGジャンル情報
		{
			name: :EPGDB_CONTEN_INFO,
			members: [
				[[:Vector, :EPGDB_CONTENT_DATA], :nibbleList]
			]
		},
		
		# EPG映像情報
		{
			name: :EPGDB_COMPONENT_INFO,
			members: [
				[:BYTE, :stream_content],
				[:BYTE, :component_type],
				[:BYTE, :component_tag],
				[:WString, :text_char],			# 情報
			]
		},
		
		# EPG音声情報データ
		{
			name: :EPGDB_AUDIO_COMPONENT_INFO_DATA,
			members: [
				[:BYTE, :stream_content],
				[:BYTE, :component_type],
				[:BYTE, :component_tag],
				[:BYTE, :stream_type],
				[:BYTE, :simulcast_group_tag],
				[:BYTE, :ES_multi_lingual_flag],
				[:BYTE, :main_component_flag],
				[:BYTE, :quality_indicator],
				[:BYTE, :sampling_rate],
				[:WString, :text_char],			# 詳細情報
			]
		},
		
		# EPG音声情報
		{
			name: :EPGDB_AUDIO_COMPONENT_INFO,
			members: [
				[[:Vector, :EPGDB_AUDIO_COMPONENT_INFO_DATA], :componentList],
			]
		},
		
		# EPGイベントデータ
		{
			name: :EPGDB_EVENT_DATA,
			members: [
				[:WORD, :original_network_id],
				[:WORD, :transport_stream_id],
				[:WORD, :service_id],
				[:WORD, :event_id],
			]
		},
		
		# EPGイベントグループ情報
		{
			name: :EPGDB_EVENTGROUP_INFO,
			members: [
				[:BYTE, :group_type],
				[[:Vector, :EPGDB_EVENT_DATA], :eventDataList],
			]
		},
		
		{
			name: :EPGDB_EVENT_INFO,
			members: [
				[:WORD, :original_network_id],
				[:WORD, :transport_stream_id],
				[:WORD, :service_id],
				[:WORD, :event_id],							# イベントID
				[:BYTE, :StartTimeFlag],					# start_timeの値が有効かどうか
				[:SYSTEMTIME, :start_time],					# 開始時間
				[:BYTE, :DurationFlag],						# durationの値が有効かどうか
				[:DWORD, :durationSec],						# 総時間（単位：秒）
				
				[:EPGDB_SHORT_EVENT_INFO, :shortInfo],		# 基本情報
				[:EPGDB_EXTENDED_EVENT_INFO, :extInfo],		# 拡張情報
				[:EPGDB_CONTEN_INFO, :contentInfo],			# ジャンル情報
				[:EPGDB_COMPONENT_INFO, :componentInfo],	# 映像情報
				[:EPGDB_AUDIO_COMPONENT_INFO, :audioInfo],	# 音声情報
				[:EPGDB_EVENTGROUP_INFO, :eventGroupInfo],	# イベントグループ情報
				[:EPGDB_EVENTGROUP_INFO, :eventRelayInfo],	# イベントリレー情報
				
				[:BYTE, :freeCAFlag],						# ノンスクランブルフラグ
			]
		},
		
		{
			name: :EPGDB_SERVICE_INFO,
			members: [
				[:WORD, :ONID],
				[:WORD, :TSID],
				[:WORD, :SID],
				[:BYTE, :service_type],
				[:BYTE, :partialReceptionFlag],
				[:WString, :service_provider_name],
				[:WString, :service_name],
				[:WString, :network_name],
				[:WString, :ts_name],
				[:BYTE, :remote_control_key_id],
			]
		},
		
		{
			name: :EPGDB_SERVICE_EVENT_INFO,
			members: [
				[:EPGDB_SERVICE_INFO, :serviceInfo],
				[[:Vector, :EPGDB_EVENT_INFO], :eventList],
			]
		},
		
		# 検索条件
		{
			name: :EPGDB_SEARCH_KEY_INFO,
			members: [
				[:WString, :andKey],
				[:WString, :notKey],
				[:BOOL, :regExpFlag],
				[:BOOL, :titleOnlyFlag],
				[[:Vector, :EPGDB_CONTENT_DATA], :contentList],
				[[:Vector, :EPGDB_SEARCH_DATE_INFO], :dateList],
				[[:Vector, :LONGLONG], :serviceList],
				[[:Vector, :WORD], :videoList],
				[[:Vector, :WORD], :audioList],
				[:BYTE, :aimaiFlag],
				[:BYTE, :notContetFlag],
				[:BYTE, :notDateFlag],
				[:BYTE, :freeCAFlag],
				# CMD_VER 3以降
				3,
				# 自動予約登録の条件専用
				[:BYTE, :chkRecEnd],					# 録画済かのチェックあり
				[:WORD, :chkRecDay],					# 録画済かのチェック対象期間
			]
		},
		
		# 自動予約登録情報
		{
			name: :EPG_AUTO_ADD_DATA,
			members: [
				[:DWORD, :dataID],
				[:EPGDB_SEARCH_KEY_INFO, :searchInfo],	# 検索キー
				[:REC_SETTING_DATA, :recSetting],		# 録画設定
				[:DWORD, :addCount],					# 予約登録数
			]
		},
		
		{
			name: :MANUAL_AUTO_ADD_DATA,
			members: [
				[:DWORD, :dataID],
				[:BYTE, :dayOfWeekFlag],			# 対象曜日
				[:DWORD, :startTime],				# 録画開始時間（00:00を0として秒単位）
				[:DWORD, :durationSecond],			# 録画総時間
				[:WString, :title],					# 番組名
				[:WString, :stationName],			# サービス名
				[:WORD, :originalNetworkID],		# ONID
				[:WORD, :transportStreamID],		# TSID
				[:WORD, :serviceID],				# SID
				[:REC_SETTING_DATA, :recSetting],	# 録画設定
			]
		},
		
		# コマンド送信用
		# チャンネル変更情報
		{
			name: :SET_CH_INFO,
			members: [
				[:BOOL, :useSID],	# wONIDとwTSIDとwSIDの値が使用できるかどうか
				[:WORD, :ONID],
				[:WORD, :TSID],
				[:WORD, :SID],
				[:BOOL, :useBonCh],	# dwSpaceとdwChの値が使用できるかどうか
				[:DWORD, :space],
				[:DWORD, :ch],
			]
		},
		
		{
			name: :SET_CTRL_MODE,
			members: [
				[:DWORD, :ctrlID],
				[:WORD, :SID],
				[:BYTE, :enableScramble],
				[:BYTE, :enableCaption],
				[:BYTE, :enableData],
			]
		},
		
		{
			name: :SET_CTRL_REC_PARAM,
			members: [
				[:DWORD, :ctrlID],
				[:WString, :fileName],
				[:BYTE, :overWriteFlag],
				[:ULONGLONG, :createSize],
				[[:Vector, :REC_FILE_SET_INFO], :saveFolder],
				[:BYTE, :pittariFlag],
				[:WORD, :pittariONID],
				[:WORD, :pittariTSID],
				[:WORD, :pittariSID],
				[:WORD, :pittariEventID],
			]
		},
		
		{
			name: :SET_CTRL_REC_STOP_PARAM,
			members: [
				[:DWORD, :ctrlID],
				[:BOOL, :saveErrLog],
			]
		},
		
		{
			name: :SET_CTRL_REC_STOP_RES_PARAM,
			members: [
				[:WString, :recFilePath],
				[:ULONGLONG, :drop],
				[:ULONGLONG, :scramble],
				[:BYTE, :subRecFlag],
			]
		},
		
		{
			name: :SEARCH_EPG_INFO_PARAM,
			members: [
				[:WORD, :ONID],
				[:WORD, :TSID],
				[:WORD, :SID],
				[:WORD, :eventID],
				[:BYTE, :pfOnlyFlag],
			]
		},
		
		{
			name: :GET_EPG_PF_INFO_PARAM,
			members: [
				[:WORD, :ONID],
				[:WORD, :TSID],
				[:WORD, :SID],
				[:BYTE, :pfNextFlag],
			]
		},
		
		{
			name: :TVTEST_CH_CHG_INFO,
			members: [
				[:WString, :bonDriver],
				[:SET_CH_INFO, :chInfo],
			]
		},
		
		{
			name: :TVTEST_STREAMING_INFO,
			members: [
				[:BOOL, :enableMode],
				[:DWORD, :ctrlID],
				[:DWORD, :serverIP],
				[:DWORD, :serverPort],
				[:WString, :filePath],
				[:BOOL, :udpSend],
				[:BOOL, :tcpSend],
				[:BOOL, :timeShiftMode],
			]
		},
		
		{
			name: :NWPLAY_PLAY_INFO,
			members: [
				[:DWORD, :ctrlID],
				[:DWORD, :ip],
				[:BYTE, :udp],
				[:BYTE, :tcp],
				[:DWORD, :udpPort],	# outで実際の開始ポート
				[:DWORD, :tcpPort],	# outで実際の開始ポート
			]
		},
		
		{
			name: :NWPLAY_POS_CMD,
			members: [
				[:DWORD, :ctrlID],
				[:LONGLONG, :currentPos],
				[:LONGLONG, :totalPos],		# CMD2_EPG_SRV_NWPLAY_SET_POS時は無視
			]
		},
		
		{
			name: :NWPLAY_TIMESHIFT_INFO,
			members: [
				[:DWORD, :ctrlID],
				[:WString, :filePath],
			]
		},
		
		{
			name: :NOTIFY_SRV_INFO,
			members: [
				[:DWORD, :notifyID],	# 通知情報の種類
				[:SYSTEMTIME, :time],	# 通知状態の発生した時間
				[:DWORD, :param1],		# パラメーター１（種類によって内容変更）
				[:DWORD, :param2],		# パラメーター２（種類によって内容変更）
				[:DWORD, :param3],		# パラメーター３（種類によって内容変更）
				[:WString, :param4],	# パラメーター４（種類によって内容変更）
				[:WString, :param5],	# パラメーター５（種類によって内容変更）
				[:WString, :param6],	# パラメーター６（種類によって内容変更）
			]
		},
		
		# 連携サーバー情報
		{
			name: :COOP_SERVER_INFO,
			members: [
				[:WString, :hostName],		# アドレス
				[:WORD, :srvPort],			# サーバーアプリ待ち受けポート
				[:BOOL, :wolFlag],			# WOLによる起動を行う
				[:BYTE, :mac[6]],			# サーバーMACアドレス
				[:WORD, :magicSendPort],	# マジックパケット送信用ポート（0でLAN内ブロードキャスト、0以外でWANへの送信）
				[:BYTE, :suspendMode],		# 登録後のサスペンド動作
			]
		},
		
		{
			name: :GENRU_INFO,
			members: [
				[:BYTE, :nibble1],
				[:BYTE, :nibble2],
				[:WORD, :key],
				[:WString, :name],
			]
		}
		
		# 旧Ver.については省略
	]
	
	# 数値クラス汎用定義関数
	#  破壊的なインスタンスメソッドは定義しない
	defsizeint = lambda do |bits, uflag|
		# 計算演算子は全てIntegerで返す： 10 + BYTE.new(10) と BYTE.new(10) + 10 の対称性のため
		# 故に += とかやるとIntegerになる
		Class.new.class_eval(<<-END, 'defsizeint')
			SIZE = #{bits}
			UFLAG = #{uflag}
			
			RANGE = 2 ** bits
			MAX = #{if uflag then 'RANGE - 1' else 'RANGE / 2 - 1' end}
			MIN = #{if uflag then '0' else '-RANGE / 2' end}
			
			def initialize(v = 0)
				@v = v.to_int
				normalize
			end
			
			# 型変換
			def to_int
				@v
			end
			def to_i
				to_int
			end
			def to_f
				@v.to_f
			end
			def to_s
				@v.to_s
			end
			def coerce(l)
				l.coerce(@v).reverse
			end
			
			# 演算子
			%w[~ +@ -@].each do |s|
				class_eval <<-EOS
					def \#{s}
						@v.\#{s}()
					end
				EOS
			end
			%w[+ - * / % ** == === > >= < <= << >> | ^ & <=>].each do |s|
				class_eval <<-EOS
					def \#{s}(r)
						@v.\#{s}(r)
					end
				EOS
			end
			
			
			# EDCBはx86(_64)で動くソフトなのでリトルエンディアンを基準とする
			# 8 * 2 ** n >= bits となるように n は定まる
			# 要するに、8, 16, 32, 64, 128, 256,... bitsまで切り上げられてバイナリに書き込まれる
			def to_binary(ver)
#{
				n = Math.log2((bits + 7) / 8).ceil	# 上の定義による"n"
				c = %w[C v V][n]					# 非負整数を返すようなtemplateを選ぶこと
				if c
					"[@v].pack('#{c}')"
				else
					b = 8 * 2 ** n	# 切り上げられたビット数
					<<-EOS
						t = []
						v = #{if uflag then '@v' else "if @v < 0 then @v + #{2 ** b} else @v end" end}
						#{b / 32}.times do	# 32bits毎に処理
							t << (v & 0xFFFFFFFF)
							v >>= 32
						end
						t.pack('V*')
					EOS
				end
}
			end
			def binary_size(ver) # BYTE単位で
				#{2 ** n}
			end
			def self.from_binary(ver, bin, pos)
				val, pos = from_binary_nt(ver, bin, pos)
				[self.new(val), pos]
			end
			def self.from_binary_nt(ver, bin, pos)
				raise RuntimeError, 'binary is too short' if #{2 ** n} > bin.size - pos
#{
				if c
					src = %!bin.unpack("x\#{pos}#{c}")[0]!
					%([#{if uflag then src else "normalize(#{src})" end}, pos + #{2 ** n}])
				else
					<<-EOS
						t = 0
						bin.unpack("x\#{pos}V#{b / 32}").reverse_each{|c| t = (t << 32) + c}
						[#{if uflag then 't' else 'normalize(t)' end}, pos + #{2 ** n}]
					EOS
				end
}
			end
			
			def self.sizeof
				#{2 ** n}
			end
			def self.normalize(v)
				v %= RANGE
				#{'if v > MAX then v -= RANGE end' unless uflag}
				v
			end
			
		private
			def normalize
				@v %= RANGE
				#{'if @v > MAX then @v -= RANGE end' unless uflag}
			end
			
			self
		END
	end
	defsizesint = lambda{|bits| defsizeint[bits, false]}
	defsizeuint = lambda{|bits| defsizeint[bits, true]}
	
	# 文字列クラス汎用定義関数
	#  破壊的なインスタンスメソッドは定義しない
	defstring = lambda do |encoding|
		Class.new.class_eval(<<-END, 'defstring')
			ENCODING = #{encoding.dump}
			NULLSTR = "\x0".encode(#{encoding.dump})
			NULLSTRLEN = NULLSTR.dup.force_encoding('ASCII-8BIT').length
			
			def initialize(s = '')
				@s = s.dup.force_encoding(#{encoding.dump})
				@sn = (@s + NULLSTR).force_encoding('ASCII-8BIT')
			end
			
			# 型変換
			def to_str
				@s
			end
			def to_s
				to_str
			end
			def to_i
				@s.to_i
			end
			def to_f
				@s.to_f
			end
			
			# 演算子
			%w[+ * % == === > >= < <= <=> =~].each do |s|
				class_eval <<-EOS
					def \#{s}(r)
						@s.\#{s}(r)
					end
				EOS
			end
			def [](*arg)
				@s.[](*arg)
			end
			
			def to_binary(ver)
				DWORD.new(binary_size(ver)).to_binary(ver) + @sn
			end
			def binary_size(ver)
				DWORD::sizeof + @sn.length
			end
			def self.from_binary(ver, bin, pos)
				val, pos = from_binary_nt(ver, bin, pos)
				[self.new(val), pos]
			end
			def self.from_binary_nt(ver, bin, pos)
				size, pos = DWORD::from_binary_nt(ver, bin, pos)
				len = size - DWORD::sizeof
				retpos = pos + len
				
				raise RuntimeError, 'binary is too short' if len > bin.size - pos
				[bin[pos...pos+len-NULLSTRLEN].force_encoding(#{encoding.dump}), retpos]
			end
			
			self
		END
	end
	
	# STRUCTSの要素からクラスを作る汎用定義関数
	#  破壊的なインスタンスメソッドは定義しない
	defstruct = lambda do |name: nil, members: nil|
		# raise RuntimeError, 'programming error' unless name && members
		
		c = Class.new
		c.class_eval(<<-END, 'defstruct')
			def initialize(arg = {})
				@m = Hash.new
				MEMBERS.each do |m|
					next if m.kind_of?(Integer)
					# raise RuntimeError, 'programming error' unless m.instance_of?(Array)
					
					crr = arg[m[1]]
					if crr.nil?
						@m[m[1]] = nil
						next
					end
					
					case m[0]
					when Array
						case m[0][0]
						when :Vector
							if crr.kind_of?(Array)
								@m[m[1]] = Vector::from_array(crr, m[0][1])
							else
								@m[m[1]] = Vector.new
							end
						else
							# raise RuntimeError, 'need to rewire'
						end
					
					when Symbol
						crrtype = EDCB.const_get(m[0])
						if crr.instance_of?(crrtype)
							@m[m[1]] = crr
						else
							@m[m[1]] = crrtype.new(crr)
						end
						
					else
						# raise RuntimeError 'programming error'
					end
				end
			end
			def [](sym)
				@m[sym]
			end
			
			def to_binary(ver)
				s = DWORD.new(binary_size(ver)).to_binary(ver)
				
				MEMBERS.each do |m|
					if m.kind_of?(Integer)
						if ver < m then break else next end
					end
					if @m[m[1]]
						s << @m[m[1]].to_binary(ver)
					else
						s << DWORD.new(DWORD::sizeof).to_binary(ver)
					end
				end
				
				s
			end
			def binary_size(ver)
				s = DWORD::sizeof
				
				MEMBERS.each do |m|
					if m.kind_of?(Integer)
						if ver < m then break else next end
					end
					s += @m[m[1]].binary_size(ver)
				end
				
				s
			end
			def self.from_binary(ver, bin, pos)
				hash = Hash.new
				
				size, pos = DWORD::from_binary_nt(ver, bin, pos)
				retpos = pos + size - DWORD::sizeof
				
				if size != DWORD::sizeof
					MEMBERS.each do |m|
						if m.kind_of?(Integer)
							if ver < m then break else next end
						end
						
						case m[0]
						when Array
							hash[m[1]], pos = EDCB.const_get(m[0][0]).from_binary(ver, bin, pos, *m[0][1...m[0].size])
							
						when Symbol
							hash[m[1]], pos = EDCB.const_get(m[0]).from_binary(ver, bin, pos)
						end
					end
					[self.new(hash), retpos]
				else
					[nil, retpos]
				end
			end
			def self.from_binary_nt(ver, bin, pos)
				hash = Hash.new
				
				size, pos = DWORD::from_binary_nt(ver, bin, pos)
				retpos = pos + size - DWORD::sizeof
				
				if size != DWORD::sizeof
					MEMBERS.each do |m|
						if m.kind_of?(Integer)
							if ver < m then break else next end
						end
						
						case m[0]
						when Array
							hash[m[1]], pos = EDCB.const_get(m[0][0]).from_binary_nt(ver, bin, pos, *m[0][1...m[0].size])
							
						when Symbol
							hash[m[1]], pos = EDCB.const_get(m[0]).from_binary_nt(ver, bin, pos)
						end
					end
					[hash, retpos]
				else
					[nil, retpos]
				end
			end
		END
		
		c.const_set(:MEMBERS, members)
		
		c
	end
	
	class Vector < Array
		def to_binary(ver)
			s = DWORD.new(binary_size(ver)).to_binary(ver)
			s << DWORD.new(size).to_binary(ver)
			each{|c| s << c.to_binary(ver)}
			s
		end
		
		def binary_size(ver)
			DWORD::sizeof * 2 + inject(0){|r, c| r + c.binary_size(ver)}
		end
		
		def self.from_binary(ver, bin, pos, typesym)
			type = EDCB.const_get(typesym)
			arrsize, pos = DWORD::from_binary_nt(ver, bin, pos)
			nextpos = pos + arrsize - DWORD::sizeof
			arrlen, pos = DWORD::from_binary_nt(ver, bin, pos)
			tmp = self.new
			arrlen.to_i.times do
				t, pos = type.from_binary(ver, bin, pos)
				tmp << t
			end
			[tmp, nextpos]
		end
		def self.from_binary_nt(ver, bin, pos, typesym)
			type = EDCB.const_get(typesym)
			arrsize, pos = DWORD::from_binary_nt(ver, bin, pos)
			nextpos = pos + arrsize - DWORD::sizeof
			arrlen, pos = DWORD::from_binary_nt(ver, bin, pos)
			tmp = []
			arrlen.to_i.times do
				t, pos = type.from_binary_nt(ver, bin, pos)
				tmp << t
			end
			[tmp, nextpos]
		end
		def self.from_array(arr, typesym)
			type = EDCB.const_get(typesym)
			self.new(arr.map{|c| if c.nil? || c.instance_of?(type) then c else type.new(c) end})
		end
	end
	
	INT8  = defsizesint[8];  UINT8  = defsizeuint[8]
	INT16 = defsizesint[16]; UINT16 = defsizeuint[16]
	INT32 = defsizesint[32]; UINT32 = defsizeuint[32]
	INT64 = defsizesint[64]; UINT64 = defsizeuint[64]
	
	BYTE = UINT8; WORD = UINT16; DWORD = UINT32; QWORD = UINT64
	BOOL = INT8; CHAR = INT8; SHORT = INT16; INT = INT32; LONG = INT32; LONGLONG = INT64; ULONGLONG = UINT64
	
	String = defstring['UTF-8']; WString = defstring['UTF-16LE']
	
	STRUCTS.each{|c| const_set(c[:name], defstruct[c])}
	
	# SYSTEMTIMEは扱いが別
	#  メンバ変数の型は全てWORD
	class SYSTEMTIME
		def to_binary(ver)
			tmp = []
			MEMBERS.each do |m|
				tmp << @m[m[1]].to_i
			end
			tmp.pack('v*')
		end
		def binary_size(ver)
			MEMBERS.size * 2
		end
		def self.from_binary(ver, bin, pos)
			t = Hash.new
			MEMBERS.each do |m|
				t[m[1]], pos = WORD::from_binary(ver, bin, pos)
			end
			[self.new(t), pos]
		end
		def self.from_binary_nt(ver, bin, pos)
			t = Hash.new
			MEMBERS.each do |m|
				t[m[1]], pos = WORD::from_binary_nt(ver, bin, pos)
			end
			[t, pos]
		end
	end
	
	private_constant :STRUCTS
end
