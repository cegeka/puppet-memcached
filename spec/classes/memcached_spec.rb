#!/usr/bin/env rspec

require 'spec_helper'

describe 'memcached' do
  it { should contain_class 'memcached' }
end
