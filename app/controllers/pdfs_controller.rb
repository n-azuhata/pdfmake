class PdfsController < ApplicationController

def createpdf
  data = []
  #ajaxで受け取った値を格納
  data << params

  require 'thinreports'

  #tlfファイルを読み込む
  report = Thinreports::Report.new :layout => "app/pdfs/withdrawalSlip6.tlf"

  data.each do |header|
      # 1ページ目
    report.start_new_page
    #ThinReports Editorで設定したIDに値を代入
    report.page.item(:filingDate).value(params["filingDate"])
    report.page.item(:name).value(params["name"])
    report.page.item(:type).value(params["type"])
    report.page.list do |list|
    #合計料金
    total= 0
    #規定行数
    count=10

      # Dispatch at list-footer insertion.
      list.on_footer_insert do |footer|
        # 合計料金をセット
        footer.item(:total).value(total)
      end

      # 該当配列の値から行を作成、合計料金の計算
      header["details"].each do |detail|
        list.add_row(detail)
        total += detail["fee"]
        # 空白行のカウント
        if count > 0 then
          count =count-1
        elsif count <= 0 then
          count = 9
        end
      end

      #空白行を作成
      count.times do |num|
        report.page.list.add_row
      end
    end
  end
  #PDFのデータを返す
  send_data report.generate
end
end
