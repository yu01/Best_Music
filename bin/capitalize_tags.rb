#!/path/to/your/rails/script/runner

@posts = Post.order(:updated_at).reverse_order

@posts = @posts.where("suit = true")

@posts = @posts.where("created_at < ?", Time.now)

p @posts[0]
