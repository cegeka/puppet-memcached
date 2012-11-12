#!/usr/bin/env rspec

require 'spec_helper'

describe 'memcached' do
  it { should contain_class('memcached') }
  it { should contain_service('memcached').with_ensure('running') }
  it { should contain_package('memcached').with_ensure('installed') }
end
