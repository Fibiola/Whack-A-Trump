require 'gosu'

class WhackATrump < Gosu::Window

# initilizing, drawing image , setting speed
	def initialize
		super(900, 600) # size of the initiated window
		self.caption = 'Whack A Trump!' #title of the game
		@image = Gosu::Image.new('trump_circular2.png') #image that should be drawn"
		@x = 200 # location from left
		@y = 200 # location from up
		@width = 240 #image size width
		@height = 346 #image size height
		@velocity_x = 2 # speed at which image moves to the right
		@velocity_y = 2 # speed at which image moves south
		@visible = 0
		@hammer_image = Gosu::Image.new('hammer.png') # Hammer defined 
		@hit = 0 # setting hits to zero
	end
# 
	def update
		@x += @velocity_x # x should move in the velocity of velocity_x
		@y += @velocity_y # y should move in the velocity of velocity_y
		@velocity_x *= -1 if @x + @width / 2 > 900 || @x - @width / 2 < 0 # shifting 0 cordinate to the center of the x axis the image
		@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0 # shifting 0 cordinate to the center of the y axis of the image
		@visible -= 1 # lower number visible by 1.
		@visible = 40 if @visible < - 10 && rand <0.01 # set visibility to 30 if visible is more than - 10 
	end

	def button_down(id)
		if (id == Gosu::MsLeft)
			if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
				@hit = 1
			else
				@hit = -1
			end
		end
	end

	def draw
		if @visible > 0 #if visible is not zero, display image
			@image.draw(@x - @width / 2, @y - @height / 2, 1) # draw image 
		end
		@hammer_image.draw(mouse_x - 40, mouse_y - 10, 1) # drawing image whereever the mouse is located
		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		elsif @hit == -1
			c = Gosu::Color::RED
		end
		draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
		@hit = 0
	end

end

window = WhackATrump.new
window.show