# vim:ft=ruby:ts=2:sw=2:et:sts=2:fileencoding=utf-8:

# override plugin/ja/00default.rb
#
add_conf_proc( 'default', '��{' ) do
  saveconf_default
  <<-HTML
  <div class="control-group">
    <label class="control-label" for="site_name">
      <a href="#" id="blob" rel="tooltip" title="�T�C�g�����w�肵�܂�">�T�C�g��</a>
    </label>
    <div class="controls">
      <input name="site_name" id="site_name" value="#{h(@conf.site_name)}" size="40">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="author_name">
      <a href="#" rel="tooltip" title="���Ȃ��̖��O���w�肵�܂�">���Җ�</a>
    </label>
    <div class="controls">
      <input name="author_name" id="author_name" value="#{h(@conf.author_name)}" size="40">
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="mail">
      <a href="#" rel="tooltip" title="���Ȃ��̃��[���A�h���X���w�肵�܂��B1�s��1�A�h���X���w�肵�܂�">���[���A�h���X</a>
    </label>
    <div class="controls">
      <textarea name="mail" id="mail" rows="4" cols="50">#{h(@conf.mail.join("\n"))}</textarea>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label" for="author_name">
      <a href="#" rel="tooltip" title="�y�[�W�̍X�V���������ꍇ�Ƀ��[���Œʒm���邩�ǂ������w�肵�܂��B���[���͊�{�ݒ�Ŏw�肵���A�h���X�ɑ��M����܂��B���炩����hikiconf.rb��SMTP�T�[�o��ݒ肵�Ă����Ă��������B">�X�V�����[���Œʒm</a>
    </label>
    <div class="controls">
      <select name="mail_on_update">
         <option value="true"#{@conf.mail_on_update ? ' selected' : ''}>���[���Œʒm</option>
         <option value="false"#{@conf.mail_on_update ? '' : ' selected'}>��ʒm</option>
      </select>
    </div>
  </div>
HTML
end

add_conf_proc( 'password', '�p�X���[�h' ) do
    case saveconf_password
    when :password_change_success
      '<div class="alert"><p>�Ǘ��җp�p�X���[�h��ύX���܂����B</p></div>'
    when :password_change_failure
      '<div class="alert"><p>�Ǘ��җp�p�X���[�h���Ԉ���Ă��邩�A�p�X���[�h����v���܂���B</p></div>'
    when nil
      '<div class="alert"><p>�Ǘ��җp�p�X���[�h��ύX���܂��B</p></div>'
    end +
    <<-HTML
        <div class="control-group">
          <label class="control-label" for="old_password">���݂̃p�X���[�h</label>
          <div class="controls">
            <input type="password" name="old_password" size="40">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password1">�V�����p�X���[�h</label>
          <div class="controls">
            <input type="password" name="password1" size="40">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password2">�V�����p�X���[�h(�m�F)</label>
          <div class="controls">
            <input type="password" name="password2" size="40">
          </div>
        </div>
    HTML
end
 
add_conf_proc( 'theme', '�\���ݒ�' ) do
  saveconf_theme
  r = <<-HTML
        <div class="control-group">
          <label class="control-label" for="theme">
            <a href="#" rel="tooltip" title="�\���Ɏg�p����e�[�}��I�����邱�Ƃ��ł��܂��B">�e�[�}�̎w��</a>
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
            <a href="#" rel="tooltip" title="�e�[�}������URL���w�肷�邱�Ƃ��ł��܂��B����CSS���w�肵���ꍇ�A��́u�e�[�}�̎w��v�őI�������e�[�}�͖�������A�w�肵��CSS���g���܂��B">�e�[�}URL�̎w��</a>
          </label>
          <div class="controls">
            <input name="theme_url" value="#{h(@conf.theme_url)}" size="60">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="theme_path">
            <a href="#" rel="tooltip" title="�e�[�}������f�B���N�g�����w�肷�邱�Ƃ��ł��܂��B�i�����ݒu���Ɏg�p�j">�e�[�}�f�B���N�g���̎w��</a>
          </label>
          <div class="controls">
            <input name="theme_path" value="#{h(@conf.theme_path)}" size="60">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="sidebar">
            <a href="#" rel="tooltip" title="�e�[�}�ɂ���Ă̓T�C�h�o�[�𗘗p����ƕ\�����������̂�����܂��B���̏ꍇ�A�T�C�h�o�[�̕\�����I�t�ɂ��邱�Ƃ��ł��܂��B">�T�C�h�o�[�̗��p</a>
          </label>
          <div class="controls">
            <select name="sidebar">
              <option value="true"#{@conf.use_sidebar ? ' selected' : ''}>�g�p����</option>
              <option value="false"#{@conf.use_sidebar ? '' : ' selected'}>�g�p���Ȃ�</option>
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="main_class">
            <a href="#" rel="tooltip" title="�f�t�H���g�ł͖{�������̃N���X���Ƃ���'main'���g�p���܂����A����ȊO�̃N���X�����g�p�������ꍇ�Ɏw�肵�܂��B">���C���G���A�̃N���X��(CSS)�̎w��</a>
          </label>
          <div class="controls">
            <input name="main_class" value="#{h(@conf.main_class)}" size="20">
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="sidebar_class">
            <a href="#" rel="tooltip" title="�f�t�H���g�ł̓T�C�h�o�[�̃N���X���Ƃ���'sidebar'���g�p���܂����A����ȊO�̃N���X�����g�p�������ꍇ�Ɏw�肵�܂��B">�T�C�h�o�[�̃N���X��(CSS)�̎w��</a>
          </label>
          <div class="controls">
            <input name="sidebar_class" value="#{h(@conf.sidebar_class)}" size="20">
          </div>
        </div>
        
        <div class="control-group">
          <label class="control-label" for="auto_link">
            <a href="#" rel="tooltip" title="�����̃y�[�W�Ɏ����I�Ƀ����N��ݒ肷��I�[�g�����N�@�\���g�p���邩�ǂ����w�肵�܂��B">�I�[�g�����N�̗��p</a>
          </label>
          <div class="controls">
            <select name="auto_link">
              <option value="true"#{@conf.auto_link ? ' selected' : ''}>�g�p����</option>
              <option value="false"#{@conf.auto_link ? '' : ' selected'}>�g�p���Ȃ�</option>
            </select>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="use_wikiname">
            <a href="#" rel="tooltip" title="WikiName �ɂ�郊���N�@�\���g�p���邩�ǂ����w�肵�܂��B">WikiName �ɂ�郊���N�@�\�̗��p</a>
          </label>
          <div class="controls">
            <select name="use_wikiname">
              <option value="true"#{@conf.use_wikiname ? ' selected' : ''}>�g�p����</option>
              <option value="false"#{@conf.use_wikiname ? '' : ' selected'}>�g�p���Ȃ�</option>
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
            <a href="#" rel="tooltip" title="XML-RPC �C���^�t�F�C�X��L���ɂ��邩�ǂ������w�肵�܂��B">XML-RPC</a>
          </label>
          <div class="controls">
            <select name="xmlrpc_enabled">
              <option value="true"#{@conf.xmlrpc_enabled ? ' selected' : ''}>�L��</option>
              <option value="false"#{@conf.xmlrpc_enabled ? '' : ' selected'}>����</option>
            </select>
          </div>
        </div>
  HTML
end
