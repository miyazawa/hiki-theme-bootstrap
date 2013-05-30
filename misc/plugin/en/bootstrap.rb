# vim:ft=ruby:ts=2:sw=2:et:sts=2:fileencoding=utf-8:

# override plugin/en/00default.rb
#
add_conf_proc( 'default', 'Basic preferences' ) do
  saveconf_default
  <<-HTML
  <div class="control-group">
    <label class="control-label" for="site_name">
      <a href="#" id="blob" rel="tooltip" title="Enter the name of your site.  This will appear in page titles.">Site name</a>
    </label>
    <div class="controls">
      <input name="site_name" id="site_name" value="#{h(@conf.site_name)}" size="40">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="author_name">
      <a href="#" rel="tooltip" title="Enter your name.">Author</a>
    </label>
    <div class="controls">
      <input name="author_name" id="author_name" value="#{h(@conf.author_name)}" size="40">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="mail">
      <a href="#" rel="tooltip" title="Enter your e-mail address. (One address in one line)">E-mail address</a>
    </label>
    <div class="controls">
      <textarea name="mail" id="mail" rows="4" cols="50">#{h(@conf.mail.join("\n"))}</textarea>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="mail_on_update">
      <a href="#" rel="tooltip" title="Set whether or not you want to have e-mail sent when a page is updated.  E-mail will be sent to the address set in the Basic Preferences.  (Make sure to specify an SMTP server beforehand in hikiconf.rb.)">Send update e-mails?</a>
    </label>
    <div class="controls">
      <select name="mail_on_update">
         <option value="true"#{@conf.mail_on_update ? ' selected' : ''}>Yes</option>
         <option value="false"#{@conf.mail_on_update ? '' : ' selected'}>No</option>
      </select>
    </div>
  </div>
HTML
end

add_conf_proc( 'password', 'Password' ) do
    case saveconf_password
    when :password_change_success
      '<div class="alert">The admin password has been changed successfully.</div>'
    when :password_change_failure
      '<div class="alert">The old password is wrong or new passwords are not same.</div>'
    when nil
      '<div class="alert">You can change the admin password.</div>'
    end +
    <<-HTML
        <div class="control-group">
          <label class="control-label" for="old_password">Current password: </label>
          <div class="controls">
            <input type="password" name="old_password" size="40">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password1">New password: </label>
          <div class="controls">
            <input type="password" name="password1" size="40">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password2">New password (confirm): </label>
          <div class="controls">
            <input type="password" name="password2" size="40">
          </div>
        </div>
    HTML
end
 
add_conf_proc( 'theme', 'Appearance' ) do
  saveconf_theme
  r = <<-HTML
        <div class="control-group">
          <label class="control-label" for="theme">
            <a href="#" rel="tooltip" title="Select a theme to use in displaying pages.">Theme</a>
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
            <a href="#" rel="tooltip" title="Specify a URL where a theme is located.  If you specify a CSS URL, the theme selected above will be ignored, and the CSS will be used.">Theme URL</a>
          </label>
          <div class="controls">
            <input name="theme_url" value="#{h(@conf.theme_url)}" size="60">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="theme_path">
            <a href="#" rel="tooltip" title="Enter the directory where themes are located.">Theme directory</a>
          </label>
          <div class="controls">
            <input name="theme_path" value="#{h(@conf.theme_path)}" size="60">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="sidebar">
            <a href="#" rel="tooltip" title="Some themes cannot properly display the sidebar.  If you are using one of these themes, set this value to off.">Sidebar</a>
          </label>
          <div class="controls">
            <select name="sidebar">
              <option value="true"#{@conf.use_sidebar ? ' selected' : ''}>On</option>
              <option value="false"#{@conf.use_sidebar ? '' : ' selected'}>Off</option>
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="main_class">
            <a href="#" rel="tooltip" title="Enter the CSS class name for the main area (default: 'main').">CSS class name for the main area</a>
          </label>
          <div class="controls">
            <input name="main_class" value="#{h(@conf.main_class)}" size="20">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="sidebar_class">
            <a href="#" rel="tooltip" title="Enter the CSS class name for the sidebar (default: 'sidebar').">CSS class name for the sidebar</a>
          </label>
          <div class="controls">
            <input name="sidebar_class" value="#{h(@conf.sidebar_class)}" size="20">
          </div>
        </div>
        
        <div class="control-group">
          <label class="control-label" for="auto_link">
            <a href="#" rel="tooltip" title="If you want to use the auto link function, set this value to on.">Auto link</a>
          </label>
          <div class="controls">
            <select name="auto_link">
              <option value="true"#{@conf.auto_link ? ' selected' : ''}>On</option>
              <option value="false"#{@conf.auto_link ? '' : ' selected'}>Off</option>
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="use_wikiname">
            <a href="#" rel="tooltip" title="If you want to disable WikiName, set this value to off.</p>">WikiName</a>
          </label>
          <div class="controls">
            <select name="use_wikiname">
              <option value="true"#{@conf.use_wikiname ? ' selected' : ''}>On</option>
              <option value="false"#{@conf.use_wikiname ? '' : ' selected'}>Off</option>
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
            <a href="#" rel="tooltip" title="If you want to disable XML-RPC interfaces, set this value to off.">XML-RPC</a>
          </label>
          <div class="controls">
            <select name="xmlrpc_enabled">
              <option value="true"#{@conf.xmlrpc_enabled ? ' selected' : ''}>On</option>
              <option value="false"#{@conf.xmlrpc_enabled ? '' : ' selected'}>Off</option>
            </select>
          </div>
        </div>
  HTML
end
