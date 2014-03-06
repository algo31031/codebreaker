# Part I 笔记

### The RSpec Book的推荐使用环境:

Ruby and Gem Versions:    
> ruby-1.8.7 1  
> rubygems-1.3.7  
> rspec-2.0.0  
> rspec-rails-2.0.0  
> cucumber-0.9.2  
> cucumber-rails-0.3.2  
> database_cleaner-0.5.2  
> webrat-0.7.2  
> selenium-client-1.2.18  
> rails-3.0.0  

gem install rspec -v 2.0.0 --no-ri --no-rdoc 
gem install rspec-rails -v 2.0.0 --no-ri --no-rdoc 
gem install cucumber -v 0.9.2 --no-ri --no-rdoc 
gem install cucumber-rails -v 0.3.2 --no-ri --no-rdoc 
gem install database_cleaner -v 0.5.2 --no-ri --no-rdoc 
gem install webrat -v 0.7.2 --no-ri --no-rdoc 
gem install selenium-client -v 1.2.18 --no-ri --no-rdoc 
gem install rails -v 3.0.0 --no-ri --no-rdoc

版本差异可能造成回馈信息细节有偏差, 代码应该都可通过

### rvm 相同版本Ruby下使用不同版本RubyGems
rvm install 1.8.7 -n rg137
rvm 1.8.7-rg137
gem update --system 1.3.7
rvm install 1.8.7 -n rg142
rvm 1.8.7-rg142
gem update --system 1.4.2

***

### 使用 RSpec
rspec [options] [files or directories]  
例如:  `rspec spec --color --format doc`  
      `rspec spec --backtrace`  
      
使用 Cucumber  
`cucumber [options] [ [FILE|DIR|URL][:LINE[:LINE]*] ]+`  

***

### Rails项目下安装RSpec
在 Gemfile文件下添加:  

>
    group :development, :test do
      gem 'rspec-rails', '~> 3.0.0.beta'
    end

运行`script/rails generate rspec:install`  
会在项目跟目录下生成 spec/spec_helper.rb 与 .rspec  
.rspec文件为RSpec的配置文件, 可以放在项目根目录下, 或放在主目录/home/xxx/下

***

### 书里提到的 Enumerable#inject  
Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.

If you specify a block, then for each element in enum<i> the block is passed an accumulator value (<i>memo) and the element. If you specify a symbol instead, then each element in the collection will be passed to the named method of memo. In either case, the result becomes the new value for memo. At the end of the iteration, the final value of memo is the return value fo the method.

If you do not explicitly specify an initial value for memo, then uses the first element of collection is used as the initial value of memo.

Examples:

>\# Sum some numbers  
(5..10).reduce(:+)                            #=> 45  
\# Same using a block and inject  
(5..10).inject {|sum, n| sum + n }            #=> 45  
\# Multiply some numbers  
(5..10).reduce(1, :*)                         #=> 151200  
\# Same using a block  
(5..10).inject(1) {|product, n| product * n } #=> 151200  
\# find the longest word  
longest = %w{ cat sheep bear }.inject do |memo,word|  
   memo.length > word.length ? memo : word  
end  
longest                                       #=> "sheep"  
