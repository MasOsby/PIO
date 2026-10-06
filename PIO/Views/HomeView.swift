//
//  HomeView.swift
//  PIO
//
//  Created by Mason Osby on 10/3/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    ZStack{
                        Text("PIO")
                            .font(.largeTitle.italic().bold())
                        HStack {
                            Spacer()
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                        }
                    }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Button("Test Stylist API") {
                        Task {
                            do {
                                let service = StylistService()
                                let outfit = try await service.generateOutfit()

                                print("OUTFIT RECEIVED")
                                print("Images:", outfit.images)
                                print("Description:", outfit.outfitDescription)

                            } catch {
                                print("STYLIST ERROR:", error)
                            }
                        }
                    }
                    
                    // MARK: - Closet Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Your Closet")
                                .font(.title2.bold())
                            Spacer()
                            Button("See All") {}
                                .font(.subheadline)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5) { _ in
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 120, height: 150)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Outfit Suggestions Section (optional for now)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("  Outfit Suggestions")
                            .font(.title2.bold())
                        
                        VStack(spacing: 16) {
                            ForEach(0..<3) { _ in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 180)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
