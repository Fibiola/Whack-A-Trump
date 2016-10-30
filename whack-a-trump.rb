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
		@hammer_image = Gosu::Image.new('hammer_cartoon1.png') # Hammer defined 
		@hit = 0 # setting hits to zero
		@font = Gosu::Font.new(30) #score text
		@font_title = Gosu::Font.new(50) #
		@score = 0
		@title = 'WHACK A TRUMP'
		@playing = true
		@start_time = 0
	end

	def update
		if @playing
			@x += @velocity_x # x should move in the velocity of velocity_x
			@y += @velocity_y # y should move in the velocity of velocity_y
			@velocity_x *= -1 if @x + @width / 2 > 900 || @x - @width / 2 < 0 # shifting 0 cordinate to the center of the x axis the image
			@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0 # shifting 0 cordinate to the center of the y axis of the image
			@visible -= 1 # lower number visible by 1.
			@time_left = (100 - ((Gosu.milliseconds - @start_time) / 1000))
			@playing = false if @time_left < 1
			@visible = 90 if @visible < - 10 && rand <0.01 # set visibility to 30 if visible is more than - 10 
			@playing = false if @time_left < 0
		end
	end

	def button_down(id)
		if @playing
			if (id == Gosu::MsLeft)  # if user clicked the left button
				if Gosu.distance(mouse_x, mouse_y, @x, @y) < 150 && @visible >= 0 #if distance of their click is close enough to the image
					@hit = 1
					@score += 5 #award scores if hit
					@visible = 0
				else
					@hit = -1
					@score -= 5 #denote scores if miss
				end
			end
		else 
			if (id == Gosu::KbSpace)
				@playing = true
				@visible = -10
				@start_time = Gosu.milliseconds
				@score = 0
			end
		end
	end

	def draw
		if @visible > 0 #if visible is not zero, display image
			@image.draw(@x - @width / 2, @y - @height / 2, 1)
		end
		if @playing 
			@hammer_image.draw(mouse_x - 40, mouse_y - 10, 1) # drawing image whereever the mouse is located
		end
		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		elsif @hit == -1
			c = Gosu::Color::RED
		end
		draw_quad(0, 0, c, 900, 0, c, 900, 600, c, 0, 600, c) #setting background
		@hit = 0
		@font.draw(@score.to_s, 800, 20, 2) #draw score that tells user how good they are - keeps scores of hits
		@font.draw(@time_left.to_s, 20, 20, 2) # draw time left
		@font_title.draw(@title, 250,20, 2)
		unless @playing
			@font_title.draw('Game Over', 360, 300, 3)
			@font.draw('Press the Space Bar to Play Again', 240, 80, 6)
			@hammer_image.draw(600, 300, 3)
			@visible = 20
		end
	end
end

window = WhackATrump.new
window.show