Rails.application.routes.draw do
  #get/postメソッドで'/pdfs'というURLに対してリクエストが来たら
  #pdfsControllerのcreatepdfというアクションを呼び出す。
  get '/pdfs', to: 'pdfs#createpdf'
  post '/pdfs', to: 'pdfs#createpdf'
end
