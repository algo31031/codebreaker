# Part III RSpec 1

##Chapter 12 Code Examples

###名词解释  
**subject code** 以RSpec描述出其行为的代码  
**expectation** 等同于 Assertion(断言)  
**code example** 等同于 Test method,用来展示**subject code**的作用,并通过**expectation**表现其行为  
**example group** 等同于 Test case, 一组**code example**  
**spec** spec文件, 包含一个或多个**example group**  

例如:  

>
    describe "A new Account" do
      it "should have a balance of 0" do
        account = Account.new
        account.balance.should == Money.new(0, :USD)
      end
    end

`describe`方法定义了一个**example group**, 传入的字符串代表我们要表述的系统的facet(一个新账户), 在其代码块中包含**code example**  
`it`方法定义**code example**, 传入的字符串用来描述我们所关心的facet的行为(余额应为0), 在其代码块中使用了**expectation**(account.balance.should == Money.new(0, :USD))  


###describe 方法

**参数有以下四种形式:**  
>describe "A User" { ... }  
>=> A User  
>describe User { ... }  
>=> User  
>describe User, "with no roles assigned" { ... }  
>=> User with no roles assigned  
>describe User, "should require password length between 5 and 40" { ... }  
>=> User should require password length between 5 and 40  

其中第一个参数可以是 class\module 或字符串, 若为 class\module 并且 ExampleGroup 被包含在 module 里,则 output 会连 module 名一起输出  

>
    module Authentication
      describe User, "with no roles assigned" do

会输出`Authentication::User with no roles assigned`  
第二个参数为字符串, 可不填

**我们也可以嵌套 example groups **  

例如:  

>
    describe User do
      describe "with no roles assigned" do
        it "is not allowed to view protected content" do

会输出:  

>
    User
      with no roles assigned
        is not allowed to view protected content

**context**方法是 describe 方法的别名,一般倾向于用describe描述事物, 用context表述背景(条件),  
于是上面的例子一般来说会写作:  

>
    describe User do
      context "with no roles assigned" do
        it "is not allowed to view protected content" do

###it 方法
参数形似与 describe 方法相同  
其字符串参数为以'it'开头的一句话, 用来描述代码块中代码的细节  


###Pending Examples  

**(1)**对于还未实现的  
在 it 方法里不传代码块, 则此 code example 会被当做 pending 的 example
>
    describe Newspaper do
      it "should be read all over"
    end

运行 RSpec 时, 会在 output 里有  

>
    Newspaper
      should be read all over (PENDING: Not Yet Implemented)  
>
    Pending:
      Newspaper should be read all over
        # Not Yet Implemented
        # ./newspaper_spec.rb:17   

可用于列出还未实现的功能  

**(2)**对于已有代码但是需要修改的  
加入 pending 声明, 不追加代码块, 则声明后的代码不会被执行  

>
    describe "onion rings" do
      it "should not be mixed with french fries" do
        pending "cleaning out the fryer"
        fryer_with(:onion_rings).should_not include(:french_fry)
      end
    end

可以使测试依然通过而不必将原先内容注释掉  

**(3)**用于 bug report  
如果此 bug 当前并不想修改  
可以把有问题的代码置于pending下, 避免其被执行(类似上面2的情形)  

传入 pending 的代码块会被执行, 若其不通过或者报错, 则会像普通 pending  
否则 RSpec 会报 PendingExampleFixedError, 提醒你此处无故 pending  
然后即可将 pending 移除, 因为这些代码已经可以通过测试  

>
    describe "an empty array" do
      it "should be empty" do
        pending("bug report 18976") do
          [].should be_empty
        end
      end
    end

>
    F
>
    Failures:
      1) an empty array should be empty FIXED
        Expected pending 'bug report 18976' to fail. No Error was raised.
        # ./pending_fixed.rb:4
>
    Finished in 0.00088 seconds
    1 example, 1 failure


###Hooks: Before, After, and Around

**before(:each)**  
对于example group中的每个example, 都会运行一遍  

**before(:all)**  
只运行一次, 但在其中的实例变量会被copy到每个example下  

简而言之, 除非特殊情况(如建立DB连接), 尽量都用before(:each)

**after(:each)**  
不常用, 在其中的代码一定会执行, 可用于恢复全局变量状态  

>
    before(:each) do
      @original_global_value = $some_global_value
      $some_global_value = temporary_value
    end
>
    after(:each) do
      $some_global_value = @original_global_value
    end

**after(:all)**  
不常用, 可用于最后关闭诸如DB连接等  

**around(:each)**
会把当前运行的example当做代码块传入around, 然后可运行example.run, 如:

>
    around do |example|
      # do something
      example.run 
      # do something else
    end