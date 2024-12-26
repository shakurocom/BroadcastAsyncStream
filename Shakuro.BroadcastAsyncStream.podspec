Pod::Spec.new do |s|
    s.name             = 'Shakuro.BroadcastAsyncStream'
    s.version          = '1.0.0'
    s.summary          = 'BroadcastAsyncStream'
    s.homepage         = 'https://github.com/shakurocom/BroadcastAsyncStream'
    s.license          = { :type => "MIT", :file => "LICENSE.md" }
    s.authors          = {'apopov1988' => 'apopov@shakuro.com', 'wwwpix' => 'spopov@shakuro.com'}
    s.source           = { :git => 'https://github.com/shakurocom/BroadcastAsyncStream.git', :tag => s.version }
    s.resource_bundles = { 'BroadcastAsyncStream' => ['Resources/PrivacyInfo.xcprivacy'] }
    s.swift_versions   = ['5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.9']
    s.source_files     = 'Sources/*'
    s.ios.deployment_target = '15.0'
end
