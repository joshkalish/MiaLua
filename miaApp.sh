#!/cygdrive/c/users/joshk/lua/lua53.exe
function setup()
    displayMode(FULLSCREEN)
    xMin = -10 --sets minimum x value of the screen 
    xMax = 10 --sets maximum x value of the screen 
    yMin = -10 --sets minimum y value of the screen 
    yMax = 10 --sets maximum y value of the screen 
    dx = 0.1 --sets the increments for which the lines on the graph are drawn (how far apart they are). the smaller the value passed to the parameter dx, the smoother the plot will be 

    --x is the number you are scaling between the min and the max- first parameter between the second and the third   
end


function draw()
     --draw x grid. y grid. x axis. y axis. plot function. 
    background(255, 255, 255)
    drawXGrid(xMin, xMax, 1)
    drawYGrid(yMin, yMax, 1) 
    drawXAxis(xMin, xMax)
    drawYAxis(yMin, yMax)
    plotFunction(xMin, xMax, yMin, Ymax)
    --if make dx value smaller and make circle size smaller you get more points closser together

end

function scaleX(x, xMin, xMax) 
    m = WIDTH/(xMax - xMin)
    b = (- m * xMin )
    return( (m * x) + b) 

    --returns the screen value of x (xScreen) that corresponds to the world value of x (xWorld) passed as a parameter 
end 

function scaleY(y, yMin, yMax) 
    m = HEIGHT/(yMax - yMin)
    b = - m * yMin 
    return(m * y + b) 

   --returns the screen value of y (yScreen) that corresponds to the world value of y (yWorld) passed as a parameter 
end 

function drawXAxis(yMin, yMax)
    stroke(0, 0, 0)
    strokeWidth(1) 
    yScreen= scaleY(0, yMin, yMax) --sets the ys value to the scaled y value of the x axis 
    line(0, yScreen, WIDTH, yScreen) 
 --draws horizontal line through the scaled value of the original screen 
end

function drawYAxis(xMin, xMax)
    stroke(0, 0, 0)
    strokeWidth(1) 
    xScreen = scaleX(0, xMin, xMax) --sets the xs value to the scaled x value of the y axis 
    line(xScreen, 0, xScreen, HEIGHT)
    --draws vertical line through the scaled value of the original screen 
end


function drawXGrid (xMin, xMax, dx)
    stroke(0, 255, 255)
    strokeWidth(1) 
   -- for i = 1, xMax - xMin do  

     --   line(i * WIDTH/(xMax - xMin), 0, i * WIDTH/(xMax - xMin), HEIGHT)

    for x = xMin, xMax, dx do 
        line(scaleX(x, xMin, xMax), 0, scaleX(x, xMin, xMax), HEIGHT)
        -- draw series of vertical lines from xMin to xMax seperated by same distance  
        -- all these values must be scaled to the screen using the scaleX function
    end
end 



function drawYGrid(yMin, yMax, dy)
    stroke(0, 255, 255)
    strokeWidth(1) 
   -- for i = 1, yMax - yMin do 
       -- line(0, i * HEIGHT/ (yMax - yMin), WIDTH, i * HEIGHT/ (yMax - yMin))

    for y = yMin, yMax, dy do 
        line(0, scaleY(y, yMin, yMax), WIDTH, scaleY(y, yMin, yMax))
        -- draw series of horizontal lines from yMin to yMax seperated by same distance  
        -- all these values must be scaled to the screen using the scaleY function 
    end
end


function func(x) 
-- takes a number as a parameter and returns a number 
    return (x * x) --parabola 

    --return (6 * x * x + 3 * x - 10) --parabola 
    --return (-1.5 * x - 2) --line 
    --return ((x - 3) * (x - 1) * (x + 1)) --curve 
    --return (2sin(x)) --sin curve 
    --name of function. parameter. return value 
end



function plotPoint(x, y, xMin, xMax, yMin, yMax) --draws an (x, y) point
    xs = scaleX(x, xMin, xMax)
    ys = scaleY(y, yMin, yMax)
    --world value on screen 
    noStroke()
    fill(255, 0, 0)
    ellipse(xs, ys, 5, 5)
end


function plotFunction(xMin, xMax, yMin, yMax, dx)
    strokeWidth(1)
    stroke(255, 0, 0) 
    for x = xMin, xMax, dx do 

        --keep adding until x gets beyond the right border- add until greater than x 
        --plot point at x, y combination 
        -- dx represents the horizontal distnace between the ends of line segments.  the vertical location of, and the vertical distance in between, the ends of line segments will depend on what function you coded in the function func()
       -- line(scaleX(x, xMin, xMax), scaleY(func(x), yMin, yMax), scaleX(x+dx, xMin, xMax), scaleY(func(x+dx), yMin, yMax))
        --draw line between points

        y = func(x)
        plotPoint(x, y, xMin, xMax, yMin, yMax)
    end
end

print("Starting")
plotFunction( -10, 10 , -10 , 10 , 1 )
