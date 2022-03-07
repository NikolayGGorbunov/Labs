module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'
      if verb.empty? || !routes.include?(verb)
        puts "Wrong verb. Try another."
        next
      end
      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
        next if action.empty?
      end

      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    @posts.map.with_index {|post, index| puts "#{index+1}. #{post}"}
  end

  def show
    print 'Choose id of post: '
    id = gets.chomp.to_i - 1
    puts @posts[id].nil? ? "The post doesn't exist" : @posts[id]
  end

  def create
    puts "Write yout post here:"
    @posts << gets
  end

  def update
    print 'Choose id of post: '
    id = gets.chomp.to_i - 1
    if @posts[id].nil?
      puts "The post doesn't exist"
    else
      puts "Write new post here:"
      @posts[id] = gets
    end
  end

  def destroy
    print 'Choose id of post: '
    id = gets.chomp.to_i - 1
    if @posts[id].nil?
      puts "The post doesn't exist"
    else
      @posts.delete_at(id)
      puts 'The post has been deleted'
    end
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(PostsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      PostsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
