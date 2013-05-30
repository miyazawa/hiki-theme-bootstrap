# vim:ft=ruby:ts=2:sw=2:et:sts=2:fileencoding=utf-8:

# override plugin/00default.rb
#
def hiki_header
  return "<title>#{title}</title>\n" if @conf.mobile_agent?
  s = <<EOS
  <title>#{title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="generator" content="#{@conf.generator}">
  <link rel="stylesheet" type="text/css" href="theme/bootstrap/bootstrap.css">
      <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }

      @media (max-width: 980px) {
        /* Enable use of floated navbar text */
        .navbar-text.pull-right {
          float: none;
          padding-left: 5px;
          padding-right: 5px;
        }
      }
    </style>
  <link rel="stylesheet" type="text/css" href="theme/bootstrap/bootstrap-responsive.css">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="theme/bootstrap/js/html5shiv.js"></script>
  <![endif]-->
EOS
  s
end

#===== menu override
def create_menu(data, command)
  menu = []
  if @conf.bot?
    menu << %Q!<li><a href="#{@conf.cgi_name}?c=index">#{@conf.msg_index}</a></li>!
  elsif @conf.mobile_agent?
    menu << %Q!<a href="#{@conf.cgi_name}?c=create" rel="nofollow">#{@conf.msg_create}</a>! if creatable?
    menu << %Q!<a href="#{@conf.cgi_name}?c=edit;p=#{escape(@page)}" rel="nofollow">#{@conf.msg_edit}</a>! if @page && editable?
    menu << %Q!<a href="#{@conf.cgi_name}?c=diff;p=#{escape(@page)}" rel="nofollow">#{@conf.msg_diff}</a>! if @page && editable?
    menu << %Q!#{hiki_anchor( 'FrontPage', page_name('FrontPage') )}!
    menu << %Q!<a href="#{@conf.cgi_name}?c=index">#{@conf.msg_index}</a>!
    menu << %Q!<a href="#{@conf.cgi_name}?c=search">#{@conf.msg_search}</a>!
    menu << %Q!<a href="#{@conf.cgi_name}?c=recent">#{@conf.msg_recent_changes}</a>!
    @plugin_menu.each do |c|
      next if c[:option].has_key?('p') && !(@page && editable?)
      cmd =  %Q!<a href="#{@conf.cgi_name}?c=#{c[:command]}!
      c[:option].each do |key, value|
        value = escape(@page) if key == 'p'
        cmd << %Q!;#{key}=#{value}!
      end
      cmd << %Q!">#{c[:display_text]}</a>!
      menu << cmd
    end
    menu_proc.each {|i| menu << i}
    menu << %Q!<a href="#{@conf.cgi_name}?c=login#{@page ? ";p=#{escape(@page)}" : ""}">#{@conf.msg_login}</a>! unless @user || @conf.password.empty?
    menu << %Q!<a href="#{@conf.cgi_name}?c=admin">#{@conf.msg_admin}</a>! if admin?
    menu << %Q!<a href="#{@conf.cgi_name}?c=logout">#{@conf.msg_logout}</a>! if @user && !@conf.password.empty?
  else
    menu << %Q!<li#{command == "create" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=create" rel="nofollow">#{@conf.msg_create}</a></li>! if creatable?
    menu << %Q!<li#{command == "edit" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=edit;p=#{escape(@page)}" rel="nofollow">#{@conf.msg_edit}</a></li>! if @page && editable?
    menu << %Q!<li#{command == "diff" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=diff;p=#{escape(@page)}" rel="nofollow">#{@conf.msg_diff}</a></li>! if @page && editable?
    menu << %Q!<li#{command == "view" ? ' class="active"' : ''}>#{hiki_anchor( 'FrontPage', page_name('FrontPage') )}</li>!
    menu << %Q!<li#{command == "index" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=index">#{@conf.msg_index}</a></li>!
    menu << %Q!<li#{command == "search" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=search">#{@conf.msg_search}</a></li>!
    menu << %Q!<li#{command == "recent" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=recent">#{@conf.msg_recent_changes}</a></li>!

    @plugin_menu.each do |c|
      next if c[:option].has_key?('p') && !(@page && editable?)
      cmd =  %Q!<li><a href="#{@conf.cgi_name}?c=#{c[:command]}!
      c[:option].each do |key, value|
        value = escape(@page) if key == 'p'
        cmd << %Q!;#{key}=#{value}!
      end
      cmd << %Q!">#{c[:display_text]}</a></li>!
      menu << cmd
    end

    menu_proc.each {|i| menu << i}
    menu << %Q!<li#{command == "admin" ? ' class="active"' : ''}><a href="#{@conf.cgi_name}?c=admin">#{@conf.msg_admin}</a></li>! if admin?
  end
  p @conf.template
  menu
end

def create_menu_right(data, command)
    menu = ""
    menu << %Q!<a href="#{@conf.cgi_name}?c=login#{@page ? ";p=#{escape(@page)}" : ""}">#{@conf.msg_login}</a>! unless @user || @conf.password.empty?
    if @user && !@conf.password.empty?
      menu << %Q!<a href="#{@conf.cgi_name}?c=logout" rel="tooltip" data-placement="bottom" title="Login as #{@user}">#{@conf.msg_logout}</a>!
    end
    menu
end

def hiki_menu(data, command)
  menu = create_menu(data, command)
  if @conf.mobile_agent?
    data[:tools] = menu.join('|')
  else
    data[:tools] = menu.join("\n")
    data[:tools_right] = create_menu_right(data, command)
  end
end

