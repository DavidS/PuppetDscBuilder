Describe 'Test-SymLinkedItem' {
  InModuleScope puppet.dsc {
    Context 'Basic verification' {
      Mock Get-Item {
        return [PSCustomObject]@{ LinkType = 'SymLink' ; Path = $Path }
      } -ParameterFilter { $Path -eq 'TestDrive:\foo\bar\baz\qux' }
      Mock Get-Item {
        return [PSCustomObject]@{ LinkType = $null ; Path = $Path }
      } -ParameterFilter { $Path -eq 'TestDrive:\foo\bar\baz' }
      Mock Get-Item {
        return [PSCustomObject]@{ LinkType = 'SymLink' ; Path = $Path }
      } -ParameterFilter { $Path -eq 'TestDrive:\foo\bar' }

      It 'returns true if the specified path is a symlink' {
        Test-SymLinkedItem -Path 'TestDrive:\foo\bar\baz\qux' | Should -BeTrue
      }
      It 'returns false if the specified path is not a symlink' {
        Test-SymLinkedItem -Path 'TestDrive:\foo\bar\baz' | Should -BeFalse
      }
      It 'returns true if any part of the path is a symlink and -Recurse is specified' {
        Test-SymLinkedItem -Path 'TestDrive:\foo\bar\baz' -Recurse | Should -BeTrue
      }
    }
  }
}
