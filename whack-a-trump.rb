require 'gosu'

class WhackATrump < Gosu::Window

	def initialize
		super(900, 600)
		self.caption = 'Whack A Trump!'
		@image = Gosu::Image.new('trump_circular2.png')
		@x = 200
		@y = 200
		@width = 240
		@height = 346
		@velocity_x = 2
		@velocity_y = 2
		@visible = 0
	end

	def update
		@x += @velocity_x
		@y += @velocity_y
		@velocity_x *= -1 if @x + @width / 2 > 900 || @x - @width / 2 < 0
		@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0 
		@visible -= 1
		@visible = 30 if @visible < - 10 && rand <0.01
	end

	def draw
		if @visible > 0
			@image.draw(@x - @width / 2, @y - @height / 2, 1)
		end
	end

end

window = WhackATrump.new
window.show