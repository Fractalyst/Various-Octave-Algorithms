function sphere_plane_intersection_demo()
    % Demonstrates:
    % 1) A sphere
    % 2) An arbitrarily oriented plane
    % 3) Their intersection circle (true 3D geometry)
    % 4) The projected ellipse in the XY plane

    sphere_radius = 1;

    % ----- Plane definition -----
    plane_normal = [1; 2; 1];
    plane_normal = plane_normal / norm(plane_normal);

    plane_offset = -0.2; % shifts plane away from origin

    % ----- Distance from sphere center to plane -----
    distance_to_plane = abs(plane_offset);

    if distance_to_plane >= sphere_radius
        error("Plane does not intersect the sphere.");
    end

    % ----- Intersection circle radius -----
    circle_radius = sqrt(sphere_radius^2 - distance_to_plane^2);

    % ----- Center of intersection circle -----
    circle_center = -plane_offset * plane_normal;

    % ----- Orthonormal basis in the plane -----
    arbitrary_vector = [1; 0; 0];

    if abs(dot(arbitrary_vector, plane_normal)) > 0.9
        arbitrary_vector = [0; 1; 0];
    end

    plane_basis_u = cross(plane_normal, arbitrary_vector);
    plane_basis_u = plane_basis_u / norm(plane_basis_u);

    plane_basis_v = cross(plane_normal, plane_basis_u);

    % ----- Parametric circle -----
    angle_values = linspace(0, 2 * pi, 400);
    circle_points = ...
        circle_center + ...
        circle_radius * ...
        (plane_basis_u * cos(angle_values) + ...
        plane_basis_v * sin(angle_values));

    % ----- Sphere mesh -----
    [sphere_x, sphere_y, sphere_z] = sphere(50);

    % ----- Plane mesh -----
    plane_size = 1.5;
    [plane_x, plane_y] = meshgrid(linspace(-plane_size, plane_size, 20));
    plane_z = ...
        (-plane_normal(1) * plane_x ...
        -plane_normal(2) * plane_y ...
        -plane_offset) / plane_normal(3);

    % ----- 3D plot -----
    figure;
    subplot(1, 2, 1);
    hold on;
    axis equal;
    grid on;
    view(3);

    surf(sphere_radius * sphere_x, ...
        sphere_radius * sphere_y, ...
        sphere_radius * sphere_z, ...
        'FaceAlpha', 0.2, 'EdgeColor', 'none');

    surf(plane_x, plane_y, plane_z, ...
        'FaceAlpha', 0.4, 'EdgeColor', 'none');

    plot3(circle_points(1, :), ...
        circle_points(2, :), ...
        circle_points(3, :), ...
        'k', 'LineWidth', 2);

    title('Sphere–Plane Intersection (3D)');
    xlabel('X'); ylabel('Y'); zlabel('Z');

    % ----- Projection to XY plane -----
    subplot(1, 2, 2);
    hold on;
    axis equal;
    grid on;

    plot(circle_points(1, :), circle_points(2, :), ...
        'k', 'LineWidth', 2);

    title('Projection onto XY Plane (Ellipse)');
    xlabel('X'); ylabel('Y');
end
