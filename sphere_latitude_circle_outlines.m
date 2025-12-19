function sphere_latitude_circle_outlines(number_of_circles)

    if nargin < 1
        number_of_circles = 200;
    end

    sphere_radius = 1;

    % Z positions from top to bottom of sphere
    z_positions = linspace(sphere_radius, -sphere_radius, number_of_circles);

    angle_values = linspace(0, 2 * pi, 300);

    figure;
    hold on;
    axis equal;
    grid on;
    view(3);

    for circle_index = 1:number_of_circles

        z_value = z_positions(circle_index);

        % Radius of circle at this height
        circle_radius = sqrt(sphere_radius^2 - z_value^2);

        % Parametric circle
        x_values = circle_radius * cos(angle_values);
        y_values = circle_radius * sin(angle_values);
        z_values = z_value * ones(size(angle_values));

        % Draw outline
        plot3(x_values, y_values, z_values, 'k');

    end

    title(sprintf('Outlines of %d horizontal sphere cuts', number_of_circles));
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
end
