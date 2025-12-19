function flattened_sphere_slices_with_oval()
    % sinusoidal (Sanson–Flamsteed) projection
    % sinusoidal lens
    figure;
    hold on;
    axis equal;
    grid on;

    sphere_radius = 1;

    % -----------------------------
    % Vertical slices (gore slices)
    % -----------------------------
    vertical_gore_slices = 12;
    latitude_steps = 200;

    latitude_values = linspace(-pi / 2, pi / 2, latitude_steps);

    % Precompute variables for a single slice
    vertical_position = latitude_values + 4; % use latitude directly
    longitude_slice_angle = (2 * pi) / vertical_gore_slices;
    equatorial_slice_width = sphere_radius * longitude_slice_angle;
    slice_widths_at_latitudes = sphere_radius * cos(latitude_values) * longitude_slice_angle;

    % Single slice boundaries relative to its center at x=0
    left_x = -slice_widths_at_latitudes / 2;
    right_x = slice_widths_at_latitudes / 2;

    % Plot all slices by translating the single slice
    for slice_index = 1:vertical_gore_slices
        slice_center_x = (slice_index - 0.5) * equatorial_slice_width - pi; % shift slices
        plot(left_x + slice_center_x, vertical_position, 'k', 'LineWidth', 1.2);
        plot(right_x + slice_center_x, vertical_position, 'k', 'LineWidth', 1.2);
    end

    % -----------------------------
    % Horizontal lines (flattened slices)
    % -----------------------------
    number_of_slices = 200;
    latitude_lines = linspace(pi / 2, -pi / 2, number_of_slices); % use latitude values

    for slice_index = 1:number_of_slices
        lat = latitude_lines(slice_index);
        circle_radius = sphere_radius * cos(lat); % horizontal width at this latitude
        circumference = 2 * pi * circle_radius;

        x_start = -circumference / 2;
        x_end = circumference / 2;
        y = lat; % vertical position = latitude

        plot([x_start, x_end], [y, y], 'k', 'LineWidth', 1.5);
    end

    % -----------------------------
    % Compute the oval equation
    % -----------------------------
    theta_steps = 81;
    theta_values = linspace(-pi / 2, pi / 2, theta_steps); % parametric angle

    oval_x = pi * sphere_radius * cos(theta_values); % horizontal width
    oval_y = theta_values - 4; % vertical positions = latitude

    % Plot the oval (both sides)
    plot(oval_x, oval_y, 'r', 'LineWidth', 2); % right side
    plot(-oval_x, oval_y, 'r', 'LineWidth', 2); % left side

    % -----------------------------
    % Labels
    % -----------------------------
    xlabel('X (circumference length)');
    ylabel('Latitude (radians)');
    title(sprintf('Flattened horizontal slices with oval outline (%d slices)', number_of_slices));
end
