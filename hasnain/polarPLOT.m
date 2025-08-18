% Original azimuthal angles and OASPL values
theta_deg = [0 30 60 90 120 150 180];

oaspl_30 = [87.68 91.2 90.28 98.8 96.26 105.74 99.72];
%oaspl_40 = [92.11 95.63 94.05 103.93 100.47 109.26 104.15];
%oaspl_50 = [95.63 99.16 101.14 106.16 102.64 111.76 107.68];

% Generate moderately dense theta range: ~70 points
theta_interp_deg = linspace(0, 180, 0);  % ~10 per segment, not excessive
theta_interp_rad = deg2rad(theta_interp_deg);

% Apply spline interpolation
oaspl_30_interp = spline(theta_deg, oaspl_30, theta_interp_deg);
oaspl_40_interp = spline(theta_deg, oaspl_40, theta_interp_deg);
oaspl_50_interp = spline(theta_deg, oaspl_50, theta_interp_deg);

% Plot
figure;
polarplot(theta_interp_rad, oaspl_30_interp, 'b-', 'LineWidth', 2); hold on;
polarplot(theta_interp_rad, oaspl_40_interp, 'g-', 'LineWidth', 2);
polarplot(theta_interp_rad, oaspl_50_interp, 'r-', 'LineWidth', 2);

% Add original points
polarplot(deg2rad(theta_deg), oaspl_30, 'bo', 'MarkerFaceColor', 'b');
polarplot(deg2rad(theta_deg), oaspl_40, 'go', 'MarkerFaceColor', 'g');
polarplot(deg2rad(theta_deg), oaspl_50, 'ro', 'MarkerFaceColor', 'r');

title('OASPL Directivity Plot (Spline, Moderately Smoothed)');
legend('30% RPM', '40% RPM', '50% RPM', 'Location', 'bestoutside');

ax = gca;                        % Get current polar axes
ax.ThetaTick = theta_deg;       % Set azimuth ticks
rlim([60 120]);                 % Set radial limits
rticks(60:10:130);              % Set radial tick marks
grid on;
