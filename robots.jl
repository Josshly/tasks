using HorizonSideRobots

mutable struct Coordinates
    x::Int
    y::Int
end
Coordinates() = Coordinates(0, 0)

function HorizonSideRobots.move!(coord::Coordinates, side::HorizonSide)
    if side == Nord
        coord.y += 1
    elseif side == Sud
        coord.y -= 1
    elseif side == Ost
        coord.x += 1
    elseif side == West
        coord.x -= 1
    end
end

struct CoordRobot
    robot::Robot
    coord::Coordinates
end

CoordRobot(robot) = CoordRobot(robot, Coordinates())

function HorizonSideRobots.move!(robot::CoordRobot, side)
    move!(robot.robot, side)
    move!(robot.coord, side)
end
HorizonSideRobots.isborder(robot::CoordRobot, side) = isborder(robot.robot, side)
HorizonSideRobots.putmarker!(robot::CoordRobot) = putmarker!(robot.robot)
HorizonSideRobots.ismarker(robot::CoordRobot) = ismarker(robot.robot)
HorizonSideRobots.temperature(robot::CoordRobot) = temperature(robot.robot)