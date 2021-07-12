#
# Be sure to run `pod lib lint MagentaRichEditorView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MagentaRichEditorView'
  s.version          = '0.6.0'
  s.summary          = 'MagentaRichEditorView updated version of RichEditorView'
  s.description      = <<-DESC
This pod is updated verions of other pods RichEditorView (https://github.com/cjwirth/RichEditorView) and ZSSRichTextEditor (https://github.com/nnhubbard/ZSSRichTextEditor). Here was replace deprecated API and change toolbar.
                       DESC

  s.homepage         = 'https://github.com/magenta-technology/MagentaRichEditorView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pavel Volkhin' => 'pavel.volhin@magenta-technology.com' }
  s.source           = { :git => 'https://github.com/magenta-technology/MagentaRichEditorView.git', :tag => s.version.to_s }
  s.default_subspec  = 'Core'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.2'

  s.subspec 'Core' do |ss|
    ss.source_files = ['MagentaRichEditorView/Classes/Core/**/*']
    ss.resource_bundles = {
          'MagentaRichEditorView' => ['MagentaRichEditorView/Assets/Core/editor/*', 'MagentaRichEditorView/Assets/Core/icons/*']
    }
  end
  
  s.subspec 'CustomToolbars' do |ss|
      ss.source_files = ['MagentaRichEditorView/Classes/CustomToolbars/**/*']
      ss.dependency "MagentaRichEditorView/Core"
      ss.resource_bundles = {
            'MagentaRichEditorViewCustomToolbars' => ['MagentaRichEditorView/Assets/CustomToolbars/**/*']
      }
    end
end
