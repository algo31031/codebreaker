# Part III RSpec 2

###Helper Methods

我们可以在example group中定义helper方法，这样定义的helper方法可以在example group中的每个code example里使用。

例如:

>
    describe Thing do
      it "should do something when ok" do
        thing = Thing.new
        thing.set_status('ok')
        thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
        ...
      end
>
      it "should do something else when not so good" do
        thing = Thing.new
        thing.set_status('not so good')
        thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
        ...
      end
    end

可以把`thing = Thing.new`和`thing.set_status('ok')`部分提取出来,改成:

>
    describe Thing do
      def create_thing(options)
        thing = Thing.new
        thing.set_status(options[:status])
        thing
      end
>
      it "should do something when ok" do
        thing = create_thing(:status => 'ok')
        thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
        ...
      end
>
      it "should do something else when not so good" do
        thing = create_thing(:status => 'not so good')
        thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
        ...
      end
    end

还可以进一步提取为:

>
    describe Thing do
      def given_thing_with(options)
        yield Thing.new do |thing|
        thing.set_status(options[:status])
        end
      end
>
      it "should do something when ok" do
        given_thing_with(:status => 'ok') do |thing|
        thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
        ...
        end
      end
>
      it "should do something else when not so good" do
        given_thing_with(:status => 'not so good') do |thing|
        thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
        ...
      end
    end