# vim:ft=ruby:ts=2:sw=2:et:sts=2:fileencoding=utf-8:

# override plugin/ja/00default.rb
#
add_conf_proc( 'default', '基本' ) do
  saveconf_default
  <<-HTML
  <div class="control-group">
    <label class="control-label" for="site_name">
      <a href="#" id="blob" rel="tooltip" title="サイト名を指定します">サイト名</a>
    </label>
    <div class="controls">
      <input name="site_name" id="site_name" value="#{h(@conf.site_name)}" size="40">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="author_name">
      <a href="#" rel="tooltip" title="あなたの名前を指定します">著者名</a>
    </label>
    <div class="controls">
      <input name="author_name" id="author_name" value="#{h(@conf.author_name)}" size="40">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="mail">
      <a href="#" rel="tooltip" title="あなたのメールアドレスを指定します。1行に1アドレスずつ指定します">メールアドレス</a>
    </label>
    <div class="controls">
      <textarea name="mail" id="mail" rows="4" cols="50">#{h(@conf.mail.join("\n"))}</textarea>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="mail_on_update">
      <a href="#" rel="tooltip" title="ページの更新があった場合にメールで通知するかどうかを指定します。メールは基本設定で指定したアドレスに送信されます。あらかじめhikiconf.rbでSMTPサーバを設定しておいてください。">更新をメールで通知</a>
    </label>
    <div class="controls">
      <select name="mail_on_update">
         <option value="true"#{@conf.mail_on_update ? ' selected' : ''}>メールで通知</option>
         <option value="false"#{@conf.mail_on_update ? '' : ' selected'}>非通知</option>
      </select>
    </div>
  </div>
HTML
end

add_conf_proc( 'password', 'パスワード' ) do
    case saveconf_password
    when :password_change_success
      '<div class="alert"><p>管理者用パスワードを変更しました。</p></div>'
    when :password_change_failure
      '<div class="alert"><p>管理者用パスワードが間違っているか、パスワードが一致しません。</p></div>'
    when nil
      '<div class="alert"><p>管理者用パスワードを変更します。</p></div>'
    end +
    <<-HTML
        <div class="control-group">
          <label class="control-label" for="old_password">現在のパスワード</label>
          <div class="controls">
            <input type="password" name="old_password" size="40">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password1">新しいパスワード</label>
          <div class="controls">
            <input type="password" name="password1" size="40">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password2">新しいパスワード(確認)</label>
          <div class="controls">
            <input type="password" name="password2" size="40">
          </div>
        </div>
    HTML
end
 
add_conf_proc( 'theme', '表示設定' ) do
  saveconf_theme
  r = <<-HTML
        <div class="control-group">
          <label class="control-label" for="theme">
            <a href="#" rel="tooltip" title="表示に使用するテーマを選択することができます。">テーマの指定</a>
          </label>
          <div class="controls">
            <select name="theme">
  HTML
  @conf_theme_list.each do |theme|
    r << %Q|<option value="#{theme[0]}"#{if theme[0] == @conf.theme then " selected" end}>#{theme[1]}</option>|
  end
  r << <<-HTML
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="theme_url">
            <a href="#" rel="tooltip" title="テーマがあるURLを指定することができます。直接CSSを指定した場合、上の「テーマの指定」で選択したテーマは無視され、指定したCSSが使われます。">テーマURLの指定</a>
          </label>
          <div class="controls">
            <input name="theme_url" value="#{h(@conf.theme_url)}" size="60">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="theme_path">
            <a href="#" rel="tooltip" title="テーマがあるディレクトリを指定することができます。（複数設置時に使用）">テーマディレクトリの指定</a>
          </label>
          <div class="controls">
            <input name="theme_path" value="#{h(@conf.theme_path)}" size="60">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="sidebar">
            <a href="#" rel="tooltip" title="テーマによってはサイドバーを利用すると表示が乱れるものがあります。その場合、サイドバーの表示をオフにすることができます。">サイドバーの利用</a>
          </label>
          <div class="controls">
            <select name="sidebar">
              <option value="true"#{@conf.use_sidebar ? ' selected' : ''}>使用する</option>
              <option value="false"#{@conf.use_sidebar ? '' : ' selected'}>使用しない</option>
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="main_class">
            <a href="#" rel="tooltip" title="デフォルトでは本文部分のクラス名として'main'を使用しますが、それ以外のクラス名を使用したい場合に指定します。">メインエリアのクラス名(CSS)の指定</a>
          </label>
          <div class="controls">
            <input name="main_class" value="#{h(@conf.main_class)}" size="20">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="sidebar_class">
            <a href="#" rel="tooltip" title="デフォルトではサイドバーのクラス名として'sidebar'を使用しますが、それ以外のクラス名を使用したい場合に指定します。">サイドバーのクラス名(CSS)の指定</a>
          </label>
          <div class="controls">
            <input name="sidebar_class" value="#{h(@conf.sidebar_class)}" size="20">
          </div>
        </div>
        
        <div class="control-group">
          <label class="control-label" for="auto_link">
            <a href="#" rel="tooltip" title="既存のページに自動的にリンクを設定するオートリンク機能を使用するかどうか指定します。">オートリンクの利用</a>
          </label>
          <div class="controls">
            <select name="auto_link">
              <option value="true"#{@conf.auto_link ? ' selected' : ''}>使用する</option>
              <option value="false"#{@conf.auto_link ? '' : ' selected'}>使用しない</option>
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="use_wikiname">
            <a href="#" rel="tooltip" title="WikiName によるリンク機能を使用するかどうか指定します。">WikiName によるリンク機能の利用</a>
          </label>
          <div class="controls">
            <select name="use_wikiname">
              <option value="true"#{@conf.use_wikiname ? ' selected' : ''}>使用する</option>
              <option value="false"#{@conf.use_wikiname ? '' : ' selected'}>使用しない</option>
            </select>
          </div>
        </div>
  HTML
end

add_conf_proc( 'xmlrpc', 'XML-RPC' ) do
  saveconf_xmlrpc

  <<-HTML
        <div class="control-group">
          <label class="control-label" for="use_wikiname">
            <a href="#" rel="tooltip" title="XML-RPC インタフェイスを有効にするかどうかを指定します。">XML-RPC</a>
          </label>
          <div class="controls">
            <select name="xmlrpc_enabled">
              <option value="true"#{@conf.xmlrpc_enabled ? ' selected' : ''}>有効</option>
              <option value="false"#{@conf.xmlrpc_enabled ? '' : ' selected'}>無効</option>
            </select>
          </div>
        </div>
  HTML
end
