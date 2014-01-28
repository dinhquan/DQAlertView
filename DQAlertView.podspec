Pod::Spec.new do |s|
  s.name         = "DQAlertView"
  s.version      = "0.1"
  s.summary      = "An iOS customizable alert view."
  s.description  = <<-DESC
                    DQAlertView is a customizable alternative to UIAlertView. 
With DQAlertView, you can easily customize the look and feel of the alert view. 
You can set the background color, background image, frame, text color, text font, appearing and disappearing animation,... handle the button touching action in some lines of code.
                   DESC
  s.homepage     = ""
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dinh Quan' => 'dinhquan191@gmail.com' }
  s.source       = { :git => "https://github.com/dinhquan/DQAlertView.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
