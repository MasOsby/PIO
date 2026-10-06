//
//  ClosetView.swift
//  PIO
//
//  Created by Mason Osby on 10/3/26.
//
import SwiftUI

struct ClosetView: View {
    // MARK: - Section titles
    let sections = ["Jackets", "Shirts", "Pants", "Shoes"]
    
    var body: some View {
        // Outer vertical scroll for the full screen
        ScrollView {
            // GeometryReader to get screen width safely (iOS 26+)
            GeometryReader { screenGeo in
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    ZStack {
                        // Centered app title
                        Text("*******")
                            .font(.largeTitle.italic().bold())
                        // Right-aligned profile icon
                        HStack {
                            Image(systemName: "camera.fill").resizable().frame(width: 38, height: 30) // a button to be able to open camera
                            Spacer() // push icon to the right
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // MARK: - Closet Sections
                    ForEach(sections, id: \.self) { section in
                        ZStack{
                            VStack(alignment: .center, spacing: 16) {
                                // Section title
                                Text(section)
                                    .font(.title2.bold())
                                    .padding(.horizontal)
                                
                                
                                // Horizontal scroll for items
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(0..<5) { index in
                                            // GeometryReader per box to get position on screen
                                            GeometryReader { geo in
                                                let style = fadeAndScale(geo: geo, screenWidth: screenGeo.size.width)
                                                
                                                Image(placeholderImage(for: section))
                                                                                                .resizable()
                                                                                                .scaledToFill()
                                                                                                .frame(width: 120, height: 150)
                                                                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                                                                .shadow(radius: 4)
                                                                                                .opacity(style.opacity)   // fade as it moves away
                                                                                                .scaleEffect(style.scale)
                                            }
                                            .frame(width: 120, height: 150)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(height: 150) // fixed height for horizontal scroll
                            }
                        }
                    }
                    Spacer(minLength: 30) // bottom padding
                }
            }
            .frame(height: 900) // adjust as needed for full content
        }
    }
    // MARK: - Helper function: choose placeholder image per section
        func placeholderImage(for section: String) -> String {
            switch section {
            case "Jackets": return "placeholder_jacket"
            case "Shirts": return "placeholder_shirt"
            case "Pants": return "placeholder_pants"
            case "Shoes": return "placeholder_shoes"
            default: return "placeholder_generic"
            }
        }
    // MARK: - Fade + Scale function
    /// Calculates opacity and scale based on distance from screen center
    func fadeAndScale(geo: GeometryProxy, screenWidth: CGFloat) -> (opacity: Double, scale: CGFloat) {
        let midX = geo.frame(in: .global).midX          // center of this box
        let screenCenter = screenWidth / 2             // center of screen
        let distance = abs(screenCenter - midX)        // distance from center
        let maxDistance = screenWidth / 2 + 120       // distance at which box is mostly faded/shrunk
        
        let opacity = max(0.1, 1 - (distance / maxDistance))        // fade
        let scale = max(0.8, 1 - (distance / (maxDistance * 2)))   // shrink slightly
        
        return (opacity, scale)
    }
}

#Preview {
    ClosetView()
}
