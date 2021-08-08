import React from 'react';
import { render } from 'react-dom';
import {
 Game, Lobby, UsersRating, UserPage, SettingsPage, RegistrationPage, Invites,
} from './App';
import Heatmap from './containers/Heatmap';
import LangPieChart from './containers/LangPieChart';

export const renderInvitesWidget = domElement => render(<Invites />, domElement);
export const renderGameWidget = domElement => render(<Game />, domElement);
export const renderLobby = domElement => render(<Lobby />, domElement);
export const renderHeatmapWidget = domElement => render(<Heatmap />, domElement);
export const renderUsersRating = domElement => render(<UsersRating />, domElement);
export const renderUserPage = domElement => render(<UserPage />, domElement);
export const renderSettingPage = domElement => render(<SettingsPage />, domElement);
export const renderRegistrationPage = domElement => render(<RegistrationPage />, domElement);
export const renderPieChartWidget = domElement => render(<LangPieChart />, domElement);
