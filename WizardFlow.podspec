
Pod::Spec.new do |s|
  s.name             = 'WizardFlow'
  s.version          = '0.1.0'
  s.summary          = 'Allow create forms or ui sequences in a wizard fashion'

  s.description      = <<-DESC
  Allow create forms or ui sequences in a wizard fashion
                       DESC

  s.homepage         = 'https://github.com/dmanuelcl/WizardFlow'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dani Manuel Céspedes Lara' => 'dmanuelcl@gmail.com' }
  s.source           = { :git => 'https://github.com/dmanuelcl/WizardFlow.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'WizardFlow/Classes/**/*'
end
