function ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind,LON_lim,LAT_lim,time)
    m_proj('miller','lon',[LON_lim(1) LON_lim(end)],'lat',[LAT_lim(1) LAT_lim(end)]);
    [ELEV,LONG,LAT] = m_etopo2([118 123 20 30]); % [ELEV,LONG,LAT]=m_etopo2([LONG_MIN LONG_MAX LAT_MIN LAT_MAX])
    m_pcolor(LONG,LAT,ELEV);shading interp

    hold on;
    m_plot(AnLLonDeg(trajectory_ind),AnLLatDeg(trajectory_ind),'k')
    hold on;
    mqr = m_quiver(AnLLonDeg(trajectory_ind),AnLLatDeg(trajectory_ind),...
        u(trajectory_ind),v(trajectory_ind),0);
    scale = 0.00001;
    mqr.Color = 'b';
    mqr.LineWidth = 1;
    mqr.LineStyle = '-';
    mqr.MarkerFaceColor = 'b';
    mqr.MaxHeadSize = 1;
    hU1 = get(mqr,'UData');
    hV1 = get(mqr,'VData');
    set(mqr,'UData',scale*hU1,'VData',scale*hV1)

    hold on;
    m_gshhs_f('patch',[0 0 0],'linewidth',0.5);
    m_grid('tickdir','out','xtick',LON_lim,'ytick',LAT_lim,'fontsize',15,...
        'xticklabels',LON_lim,'yticklabels',LAT_lim);
    hold on;
    mqr_ref = m_quiver(120+48.5/60,21+56.5/60,1000,0,0);
    mqr_ref.Color = 'w';
    mqr_ref.LineWidth = 1;
    mqr_ref.LineStyle = '-';
    mqr_ref.MarkerFaceColor = 'w';
    mqr_ref.MaxHeadSize = 1;
    hU_ref = get(mqr_ref,'UData');
    hV_ref = get(mqr_ref,'VData');
    set(mqr_ref,'UData',scale*hU_ref,'VData',scale*hV_ref)
    hold on;
    m_text(120+48.5/60,21+57/60,'1 m/s','Color','w','FontWeight','bold');
    hold on;
    m_text(120+44/60,21+59.5/60,['Start : ' char(time(trajectory_ind(1)))],...
        'Color','w','FontWeight','bold');
    m_text(120+44/60,21+58.5/60,['End : ' char(time(trajectory_ind(end)))],...
        'Color','w','FontWeight','bold');
end