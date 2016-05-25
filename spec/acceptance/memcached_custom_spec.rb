require 'spec_helper_acceptance'

describe 'memcached' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS        
        include memcached

        memcached::instance { '11212':
          ensure    => running,
          enabled   => true,
          port      => '11212',
          user      => 'memcached',
          maxconn   => '1024',
          cachesize => '512',
          options   => '',
        }

      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe port(11212) do
      it { is_expected.to be_listening }
    end

    describe service('memcached-11212') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
